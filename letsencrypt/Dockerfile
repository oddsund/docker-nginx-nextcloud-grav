FROM jrcs/letsencrypt-nginx-proxy-companion

RUN sed -i 's/location \//location ^~ \//g' /app/nginx_location.conf
