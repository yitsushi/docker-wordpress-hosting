# docker-wordpress-hosting

## Installation

    $ git clone https://github.com/Yitsushi/docker-wordpress-hosting.git
    $ cd docker-wordpress-hosting
    $ docker build -t="docker-wordpress-hosting" docker-wordpress-hosting

## Usage

To spawn a new instance of wordpress:

    root@folyam:/docker# ./addNewWordpress docker-folyam-info
    Run sandbox
    bd514adb3e218fb52f5b85b80133b149c86bd097ffc5c78ba734c6079713062b
    Copy mysql-data
    Copy wordpress-data
    Stop sandbox
    wordpress-docker-folyam-info
    wordpress-docker-folyam-info
    Run docker-folyam-info
    5dd90664d4021be8949fcf0b0ad7770216cf667a8f80b1336f7ae23a11aaaa2d
    >>> 127.0.0.1:49182
    ReGenerate HAProxy
    Domain list for wordpress-docker-folyam-info: [^D to finish]
    docker-folyam-info
     ---
    Configuration file is valid
    HAProxy Config: Nice
     * Restarting haproxy haproxy   [ OK ]
    root@folyam:/docker#

The name of the docker will be `docker-folyam-info` with a `wordpress` prefix: `wordpress-docker-folyam-info`

After the creation it will run the `generateHaproxyConfig.sh` script that generates a new HAProxy configuration file.
If a container does not have a `groups` file then it will ask you for domains. Just write the domain that you want to
forward to that conatiner. For multiple domains separate them with a simple new line. If you finish your domain list press
control+D.
