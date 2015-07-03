#!/bin/bash
sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini && \
sed -i "s/^;date\.timezone\s*=\s*$/date.timezone = Asia\/Yekaterinburg/g" /etc/php5/fpm/php.ini && \
sed -i "s/^;mbstring\.internal_encoding\s*=.*$/mbstring\.internal_encoding = UTF-8/g" /etc/php5/fpm/php.ini && \
sed -i "s/^;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf && \
sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/cli/php.ini && \
sed -i "s/^;date\.timezone\s*=\s*$/date.timezone = Asia\/Yekaterinburg/g" /etc/php5/cli/php.ini && \
sed -i "s/^;mbstring\.internal_encoding\s*=.*$/mbstring\.internal_encoding = UTF-8/g" /etc/php5/cli/php.ini && \
find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;