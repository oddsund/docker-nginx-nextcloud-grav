FROM nextcloud:fpm

RUN apt-get update && apt-get install -y \
    supervisor \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/log/supervisord /var/run/supervisord

COPY supervisord.conf /etc/supervisor/supervisord.conf

COPY nextcloud.example.com /etc/nginx/vhost.d/nextcloud.example.com

COPY nextcloud.example.com_location /etc/nginx/vhost.d/nextcloud.example.com_location

RUN cp entrypoint.sh configScript.sh && \
    sed -i s/exec "@"//g configScript.sh && \
    ./configScript.sh php-fpm && \
    rm configScript.sh

CMD ["/usr/bin/supervisord"]

