FROM php:7-apache
RUN docker-php-ext-install session && docker-php-ext-enable session && \
    docker-php-ext-install exif && docker-php-ext-enable exif && \
    docker-php-ext-install mbstring && docker-php-ext-enable mbstring && \
    docker-php-ext-install gd && docker-php-ext-enable gd && \
    docker-php-ext-install mysqli && docker-php-ext-enable mysqli && \
    docker-php-ext-install json && docker-php-ext-enable json && \
    docker-php-ext-install zip && docker-php-ext-enable zip
RUN a2enmod rewrite
RUN a2enmod expires
RUN apt-get update && apt-get install --no-install-recommends -y git
COPY php.ini /usr/local/etc/php.ini
RUN git clone https://github.com/electerious/Lychee.git /var/www/html
RUN chown -R www-data:www-data /var/www/html && chmod -R 777 /var/www/html/uploads /var/www/html/data
COPY config.php /var/www/html/data/config.php
VOLUME ["/var/www/html/uploads","/var/www/html/data"]
