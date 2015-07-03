#!/bin/bash
curl -sS https://getcomposer.org/installer | php && \
mv composer.phar /usr/local/bin/composer && \
chmod +x /usr/local/bin/composer && \
mkdir -p /composer && \
rm -rf /composer/*
