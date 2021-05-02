# PHPMemcachedAdmin
[PHPMemcachedAdmin](https://github.com/elijaa/phpmemcachedadmin) running in Alpine with Nginx and PHP-FPM.

## Usage
```
docker run --name phpmemcachedadmin -d -p <port>:8080 moonbuggy2000/phpmemcachedadmin:latest
```

Configuration can be done via the web interface, at `http://<hostname or IP>:<port>/configure.php`.

### Environment Variables
* `PUID`          - user ID to run as
* `PGID`          - group ID to run as
* `TZ`		      - set `date.timezone` in php.ini
* `NGINX_LOG_ALL` - enable logging of HTTP 200 and 300 responses (accepts: `true`, `false` default: `false`)

### Persisting Data
Configuration is stored at `/var/www/html/Config/Memcache.php`. You can mount a volume here if you wish to manually edit the configuration file.

## Links
GitHub: https://github.com/moonbuggy/docker-phpmemcachedadmin

Docker Hub: https://hub.docker.com/r/moonbuggy2000/phpmemcachedadmin
