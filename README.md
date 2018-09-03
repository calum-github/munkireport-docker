Munki Report PHP in a Container
=============

This Docker image runs [MunkiReport PHP](https://github.com/munkireport/munkireport-php).

The Docker image is built on Debian:Stretch for the newer versions

It uses Nginx and php7.2-fpm

* MySQL 5.7.7 or above is required if you are going to use MySQL for the DB backend

* Branches / versions

There are multiple branches for each version, ensure you check out the tags for each branch.


- MunkiReport PHP version 3.2.2 (July 3, 2018) - Tag 3.2.2 

- MunkiReport PHP version 2.12.0 (December 23, 2016) - Tag 2.12.0 

- MunkiReport PHP version 2.8.4 (March 15, 2015) - Tag 2.8.4

- MunkiReport PHP version 2.7.3 (December 17, 2015) - Tag 2.7.3

- MunkiReport PHP version 2.6.0 (October 20, 2015) - Tag 2.6.0

- MunkiReport PHP version 2.5.3 (July 31, 2015) - Tag 2.5.3

- MunkiReport PHP version 2.4.3 (June 2, 2015) - Tag 2.4.3

- MunkiReport PHP version 2.3.0 (March 11, 2015) - Tag 2.3.0


# Settings

Modify the /var/www/config.php as per your needs
You can provide a config.php from the host to the container by passing a volume flag in docker
``` -v /mr_config/config.php:/www/munkireport/config.php```

# Passing variables to the container
You will likely need to pass variables to the container, such as db connection information
this can be done by passing ENV variables when starting the container
eg
``` -e CONNECTION_DRIVER=mysql ```

You can then use this variable from the config.php with a line like this
```$conf['connection']['drive'] = getenv_default('CONNECTION_DRIVER', 'sqlite');```

This will then use the value that is provided via the -e command, or if this is not provided it will
use a default value, which in this case is `sqlite`

# Running the container

Running the container is quite simple.

```
$ docker run -d -p 80:80 -e TZ=Australia/Melbourne --name mr_webapp hunty1/munkireport-docker
```
