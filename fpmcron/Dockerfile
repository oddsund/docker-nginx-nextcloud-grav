FROM nextcloud:fpm

RUN apt-get update && apt-get install -y \
  supervisor \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/log/supervisord /var/run/supervisord

COPY supervisord.conf /etc/supervisor/supervisord.conf

COPY nextcloud.example.com /etc/nginx/vhost.d/nextcloud.example.com

COPY nextcloud.example.com_location /etc/nginx/vhost.d/nextcloud.example.com_location

RUN sed -Ei 's/^if expr \"\$1\" : \"apache\".*; then$//g' /entrypoint.sh && \
  sed -ri 's/^fi$//' /entrypoint.sh

CMD ["/usr/bin/supervisord"]

