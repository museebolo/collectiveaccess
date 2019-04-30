FROM canelrom1/apache-php7:latest

ENV CA_PAWTUCKET_VERSION=1.7.6

RUN apk add curl \
            mariadb-client \
            php7-ctype \
            php7-curl \
            php7-exif \
            php7-iconv \
            php7-json \
            php7-mbstring \
            php7-memcached \
            php7-phar \
            php7-simplexml \
            php7-xml \
            php7-xmlreader \
            php7-xmlwriter \
            php7-zip

RUN rm -rf /var/www/html \
 && curl -SsL https://github.com/collectiveaccess/pawtucket2/archive/$CA_PAWTUCKET_VERSION.tar.gz | tar -C /var/www/ -xzf - \
 && mv /var/www/pawtucket2-$CA_PAWTUCKET_VERSION /var/www/html \
 && cp /var/www/html/setup.php-dist /var/www/html/setup.php 

RUN chown -R apache:apache /var/www/html

COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["apache2"]

# vim: tw=200
