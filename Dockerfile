FROM debian:jessie
MAINTAINER gmiramir@gmail.com

ENV DEBIAN_FRONTEND=noninteractive

# install and update base packages
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get -y install git wget tar bzip2 curl supervisor openssh-server memcached && \
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



# # Basic Requirements
# RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server mysql-client nginx php5-fpm php5-mysql php-apc pwgen python-setuptools curl git unzip

# # Drupal Requirements
# RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5-curl php5-gd php5-intl php-pear php5-imap php5-memcache memcached drush mc

# RUN apt-get clean

# # Make mysql listen on the outside
# RUN sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf

# # nginx config
# RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
# RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# # php-fpm config
# RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini
# RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
# RUN find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

# # nginx site conf
# ADD ./nginx-site.conf /etc/nginx/sites-available/default

# # Supervisor Config
# RUN /usr/bin/easy_install supervisor
# ADD ./supervisord.conf /etc/supervisord.conf

# # Retrieve drupal
# RUN rm -rf /var/www/ ; cd /var ; drush dl drupal ; mv /var/drupal*/ /var/www/
# RUN chmod a+w /var/www/sites/default ; mkdir /var/www/sites/default/files ; chown -R www-data:www-data /var/www/

# # Drupal Initialization and Startup Script
# ADD ./start.sh /start.sh
# RUN chmod 755 /start.sh