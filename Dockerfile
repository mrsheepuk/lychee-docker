FROM php:7-apache
RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libpng12-dev
RUN docker-php-ext-install -j$(nproc) session exif mbstring gd mysqli json zip && \
        docker-php-ext-enable session exif mbstring gd mysqli json zip 
RUN a2enmod rewrite
RUN a2enmod expires
RUN apt-get update && apt-get install --no-install-recommends -y git
COPY php.ini /usr/local/etc/php.ini
RUN git clone https://github.com/electerious/Lychee.git /var/www/html
RUN chown -R www-data:www-data /var/www/html && chmod -R 777 /var/www/html/uploads /var/www/html/data
COPY config.php /var/www/html/data/config.php
VOLUME ["/var/www/html/uploads"]
