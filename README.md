Munki Report PHP in a Container
=============

This Docker image runs [MunkiReport PHP](https://github.com/munkireport/munkireport-php).
The container is expects the details of a MySQL database to be passed to it via environmental arguments

The Docker image is built on Ubuntu 14
It uses Nginx and php5-fpm

MunkiReport PHP version is 2.1.0 (November 10, 2014)


# Settings

Several options, such as the timezone and admin password are customizable using environment variables.

* ``DB_NAME``: The default database name is munkireport, if you have a different database name. Set it here as per your needs.
* ``DB_USER``: The default user to access the database with is admin. Change here as per your needs.
* ``DB_PASS``: The default user password to access the database is admin. Change here as per your needs.
* ``DB_SERVER``: The FQDN or IP address of the database server. ie sql.test.internal
* ``MR_SITENAME``: Customise the site name for Munki Report.
* ``MR_TIMEZONE``: Customise the timezone, default is Australia/Sydney

# Munki Report Login

The default user and password to log in to Munki Report is:

Username: root
Password: root

If you require more advanced settings, modify the config.php as per your needs

# Running the container

Running the container is quite simple.

```bash
$ docker run -d -p 80:80 -e DB_NAME=munkireport -e DB_USER=admin -e DB_PASS=admin -e DB_SERVER=mysql.test.internal -e MR_SITENAME=MunkiReport-MyCompany -e MR_TIMEZONE=Australia/Sydney hunty1/munki-report-docker
```

