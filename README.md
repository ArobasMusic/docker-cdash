### Setup
```shell
> docker pull arobasmusic/cdash
```

### Configuration

To customize your CDash service, mount your **CDash** config file to

`/srv/cdash/cdash/config.local.php`.

Example:

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

### Other available volumes

- `/srv/cdash/backup`
- `/srv/cdash/upload`
- `/srv/cdash/rss`
- `/var/log/apache2`
