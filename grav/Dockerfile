FROM nginx:mainline-alpine

RUN apk update && \
    apk add less vim ca-certificates git tzdata curl yaml zip openssl \
    php7-fpm php7-json php7-zlib php7-xml php7-pdo php7-phar php7-openssl \
    php7-gd php7-iconv php7-mcrypt php7-session php7-zip \
    php7-curl php7-opcache php7-ctype php7-apcu \
    php7-intl php7-bcmath php7-dom php7-mbstring php7-xmlreader && apk add -u musl && \
    rm -rf /var/cache/apk/*

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php7/php.ini && \
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php7/php.ini && \
    echo 'fastcgi_param HTTP_PROXY "";' >> /etc/nginx/fastcgi.conf && \
    echo 'fastcgi_param HTTP_PROXY "";' >> /etc/nginx/fastcgi_params && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    ln -s /sbin/php-fpm7 /sbin/php-fpm

ADD nginx.conf /etc/nginx/
ADD grav-php.conf /etc/php7/php-fpm.d/
ADD start.sh /

RUN chmod +x /start.sh

CMD ["/start.sh"]
