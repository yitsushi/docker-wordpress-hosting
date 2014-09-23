# docker-wordpress-hosting

## Installation

    $ git clone https://github.com/Yitsushi/docker-wordpress-hosting.git
    $ cd docker-wordpress-hosting
    $ docker build -t="docker-wordpress-hosting" docker-wordpress-hosting

## Usage

To spawn a new instance of wordpress:

    $ ./addNewWordpress docker-folyam-info

The name of the docker will be `docker-folyam-info` with a `wordpress` prefix: `wordpress-docker-folyam-info`

After the creation it will run the `generateHaproxyConfig.sh` script that generates a new HAProxy configuration file.
If a container does not have a `groups` file then it will ask you for domains. Just write the domain that you want to
forward to that conatiner. For multiple domains separate them with a simple new line. If you finish your domain list press
control+D.
