FROM debian:jessie
MAINTAINER gmiramir@gmail.com

ENV DEBIAN_FRONTEND=noninteractive

# install and update base packages
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get -y install git wget tar bzip2 curl supervisor openssh-server memcached vim && \
    apt-get -y install mariadb-server mariadb-client && \
    apt-get -y install nginx && \
    apt-get -y install php5-fpm php5-mysql php5-curl php5-gd php5-intl php-pear php5-imap php5-memcache && \
    apt-get -y clean

ADD ./bin /tmp/bin

RUN chmod 755 /tmp/bin/*.sh && \
	echo 'root:zxcvbnm' | chpasswd && \
	/tmp/bin/init_ssh.sh && \
	/tmp/bin/init_mysql.sh && \
	/tmp/bin/init_nginx.sh && \
	/tmp/bin/init_php.sh && \
	/tmp/bin/install_composer.sh

ADD ./supervisor /etc/supervisor

EXPOSE 22 3306

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]