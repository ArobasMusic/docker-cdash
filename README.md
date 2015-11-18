### Setup
```shell
> docker pull arobasmusic/cdash
```

### Configuration

To customize your CDash service, mount your **CDash** config file to

`/srv/cdash/cdash/config.local.php`. Example:

```shell
> cat > $PWD/config.local.php << EOF
'<?php'
\$CDASH_DB_HOST = 'db';
\$CDASH_DB_TYPE = 'mysql';
\$CDASH_DB_NAME = 'cdash';
\$CDASH_DB_PASS = 'password-for-cdash-table';
\$CDASH_DB_LOGIN = 'cdash'
EOF
> docker run --link mysql:db -v "$PWD/config.local.php":"/srv/cdash/cdash/config.local.php" -P -d arobasmusic/cdash:2.2.2
```

See [CDash setup documentation](http://public.kitware.com/Wiki/CDash:Installation#Configuration) for more details.

### SSL certificate

To use your own ssl certificate, mount your certificate et certificate key files
to `/srv/cdash-ssl-cert.crt` and `/srv/cdash-ssl-cert.key`. Example:

```shell
> docker run \
    -P \
    -d \
    --link mysql:db \
    -v "$PWD/config.local.php":"/srv/cdash/cdash/config.local.php" \
    -v "$PWD/your-certificate.crt":"/srv/cdash-ssl-cert.crt" \
    -v "$PWD/your-certificate.key":"/srv/cdash-ssl-cert.key" \
    arobasmusic/cdash:2.2.2
```

### Other available volumes

- `/srv/cdash/backup`
- `/srv/cdash/upload`
- `/srv/cdash/rss`
- `/var/log/apache2`
