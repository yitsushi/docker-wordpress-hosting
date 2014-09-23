#!/bin/bash

_l=`grep -n "%CONATINERS%" haproxy/haproxy.cfg | grep -o "^[0-9]\+"`

head -n $(($_l - 1)) haproxy/haproxy.cfg > /tmp/generated_haproxy.cfg

nameList=`docker ps "\bwordpress-" | grep -o "wordpress-[^ ]\+" | grep -v "wordpress-hosting"`

for name in $nameList; do
  if [ ! -f "/etc/haproxy/groups/${name}" ]; then
    touch /etc/haproxy/groups/${name}
    echo "Domain list for ${name}: [^D to finish]"
    cat > /etc/haproxy/groups/${name}
    echo " ---"
  fi
  echo -e "\tacl is_${name} hdr(host) -i -f /etc/haproxy/groups/${name}" >> /tmp/generated_haproxy.cfg
  echo -e "\tuse_backend ${name} if is_${name}" >> /tmp/generated_haproxy.cfg
done

_ml=`wc -l haproxy/haproxy.cfg | grep -o "^[0-9]\+"`
tail -n $(($_ml - $_l)) haproxy/haproxy.cfg >> /tmp/generated_haproxy.cfg

echo "" >> /tmp/generated_haproxy.cfg

for name in $nameList; do
  PORT=`docker port "${name}" 80 | awk -F: '{ print $2 }'`
  echo -e "backend ${name}" >> /tmp/generated_haproxy.cfg
  echo -e "\toption forwardfor" >> /tmp/generated_haproxy.cfg
  echo -e "\toption httpchk HEAD / HTTP/1.1\\\\r\\\\nHost:localhost" >> /tmp/generated_haproxy.cfg
  echo -e "\tserver ${name}1 127.0.0.1:${PORT} check" >> /tmp/generated_haproxy.cfg
done

haproxy -c -f /tmp/generated_haproxy.cfg
ret=$?
if [[ $ret -eq 0 ]]; then
  echo "HAProxy Config: Nice" >&2
else
  echo "HAProxy Config: Fail" >&2
fi
cp /tmp/generated_haproxy.cfg /etc/haproxy/haproxy.cfg
service haproxy restart
