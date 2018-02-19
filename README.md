# Nextcloud and Grav behind nginx with Lets Encrypt and automatic configuration

This is a setup with nextcloud and grav, exposed behind a nginx proxy with automatic handling of TLS certificates for secure https traffic. Certificates and configuration of the nginx-proxy will be automatically handled, and you can easily add more services.

## How to deploy

To deploy this setup, edit the database password in db.env and run the following commands from the root folder;

```[language=bash]
find . -type f | xargs sed -i 's/nextcloud\.example\.com/yourcloud\.yourdomain\.tld/g'
find . -type f | xargs sed -i 's/www\.example\.com/www\.yourdomain\.tld/g'
find . -type f | xargs sed -i 's/me@example\.com/youremail@maildomain\.com/g'
find . -type f | xargs sed -i 's/example\.com/\.yourdomain\.tld/g'
docker-compose up
```

## How to add services

To add another service exposed through a port(e.g. via apache/nginx/lighttpd), follow the grav example.
To add another service exposed through a php-only container, follow the nextcloud example.

After adding another server, simply run `docker-compose up` again to deploy the new service.

## Backup

If you want to backup parts of you installation, inspect the settings for the volume containing the data you want to backup. Usually, the volumes are mapped to folders under `/var/lib/docker/volumes`. Some tips for backuptargets are the db, grav and nextcloud volumes.

## Start with another grav-skeleton

To use another Grav-skeleton as a basis, just edit the `GRAV_URL` and `GRAV_FOLDER` in the start.sh. While the default is grav + admin plugin, you might also want to use e.g. a blog skeleton. Just find the url, and find out which folder it unzips.

## Inspiration

This setup has been heavily inspired by [yobasystems/alpine-grav](https://github.com/yobasystems/alpine-grav), the [nextcloud/docker](https://github.com/nextcloud/docker) example on docker-compose with postgres and fpm and [jwidler/nginx-proxy](https://github.com/jwilder/nginx-proxy) for the automatically configured nginx.

## Things to note

In fpmcron/nextcloud.example.com, there are multiple root directives. This is because the general directive is for the volume mounted in the nginx proxy container(static files), while the root directive under the location directive is for the message to the php-fpm process running in the nextcloud container. So if you either get the message 'File not found' when you go to your cloud url, or the static files such as images don't load, check these two directives.

While the grav container should probably be able to run as a pure fpm container, like nextcloud, I have kept it like this for the sake of providing examples for both a nginx-fpm container and a fpm-container.
