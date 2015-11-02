Munki Report PHP in a Container
=============

This Docker image runs [MunkiReport PHP](https://github.com/munkireport/munkireport-php).
The container is expects the details of a MySQL database to be passed to it via environmental arguments

The Docker image is built on Debian:Jessie

It uses Nginx and php5-fpm

* Versions

There are multiple branches for each version, ensure you check out the tags for each branch.

MunkiReport PHP version 2.3.0 (March 11, 2015) - Tag 2.3.0

MunkiReport PHP version 2.4.3 (June 2, 2015) - Tag 2.4.3

MunkiReport PHP version 2.5.3 (July 31, 2015) - Tag 2.5.3

<<<<<<< HEAD
* WIP and Master Branches

There are also tags for wip and latest, these correspond to the WIP and Master branch of MunkiReport's Github.
These are current as of August 04, 2015 but may be subject to change at any time. For specific versions, make sure you
choose the correct tag.
=======
MunkiReport PHP version 2.6.0 (October 20, 2015) - Tag 2.6.0

>>>>>>> 2.6.0


# Settings

Several options, such as the timezone and admin password are customizable using environment variables.

* ``DB_NAME``: The default database name is munkireport, if you have a different database name. Set it here as per your needs.
* ``DB_USER``: The default user to access the database with is admin. Change here as per your needs.
* ``DB_PASS``: The default user password to access the database is admin. Change here as per your needs.
* ``DB_SERVER``: The FQDN or IP address of the database server. ie sql.test.internal
* ``MR_SITENAME``: Customise the site name for Munki Report.
* ``MR_TIMEZONE``: Customise the timezone, default is Australia/Sydney

Munki Report is able to perform warranty lookups, however if your Munki Report server is behind a proxy this may fail.
To avoid this, we can provide proxy server information as variables when starting the container or providing defaults
in the Dockerfile when building the container.

There are two methods of setting the proxy server:

Mode 1
This sets just the proxy server address and port number

Mode 2
This sets the proxy server address, port number and a username and password to use if the proxy server is an authenticated proxy

* ``proxy_required``: Set this to mod1 or mod2 depending upon which type of proxy server config you need. If no proxy set to no
* ``proxy_server``: Set this to your proxy server address in the format proxy.example.com
* ``proxy_port``: Set this to your proxy server port number
* ``proxy_uname``: Set this to your proxy username if you need to use an authenticated proxy server
* ``proxy_pword``: Set this to your proxy password if you need to use an authenticated proxy server


# Munki Report Login

The default user and password to log in to Munki Report is:

Username: ``root``
Password: ``root``

If you require more advanced settings, modify the config.php as per your needs

# Running the container

Running the container is quite simple.

```bash
$ docker run -d -p 80:80 -e DB_NAME=munkireport -e DB_USER=admin -e DB_PASS=admin -e DB_SERVER=mysql.test.internal -e MR_SITENAME=MunkiReport-MyCompany -e MR_TIMEZONE=Australia/Sydney --name munkireport_webapp hunty1/munkireport-docker
```

If you need proxy server support, either bake them into your Dockerfile, or provide them as environmentals when starting your container
by passing them with the -e flag, just like the variables shown above for the DB serttings.