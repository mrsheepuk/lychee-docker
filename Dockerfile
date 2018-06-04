FROM php:7-fpm
RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libpng12-dev \
        zlib1g-dev \
	&& docker-php-ext-install -j$(nproc) iconv \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) session exif mbstring mysqli json zip \
    && docker-php-ext-enable iconv gd session exif mbstring mysqli json zip
RUN apt-get update && apt-get install -qq --no-install-recommends -y git
COPY php.ini /usr/local/etc/php.ini
RUN git clone https://github.com/electerious/Lychee.git /var/www/html
RUN chown -R www-data:www-data /var/www/html && chmod -R 777 /var/www/html/uploads /var/www/html/data
COPY config.php /var/www/html/data/config.php
VOLUME ["/var/www/html/uploads"]
