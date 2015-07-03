#!/bin/bash

sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf
/usr/bin/mysqld_safe &
sleep 10s
mysqladmin -u root password 'root'
mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'
killall mysqld
