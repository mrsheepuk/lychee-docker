FROM php:7-fpm
RUN docker-php-ext-install -j$(nproc) session exif mbstring mysqli json && \
        docker-php-ext-enable session exif mbstring mysqli json 
RUN apt-get update && apt-get install -qq -y zlib && \
        docker-php-ext-install zip && \
        docker-php-ext-enable zip
RUN apt-get update && apt-get install -qq -y libgd-dev libfreetype6-dev libjpeg62-turbo-dev libpng12-dev && \
        docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
        docker-php-ext-install gd && \
        docker-php-ext-enable gd
RUN apt-get update && apt-get install -qq --no-install-recommends -y git
COPY php.ini /usr/local/etc/php.ini
RUN git clone https://github.com/electerious/Lychee.git /var/www/html
RUN chown -R www-data:www-data /var/www/html && chmod -R 777 /var/www/html/uploads /var/www/html/data
COPY config.php /var/www/html/data/config.php
VOLUME ["/var/www/html/uploads"]
