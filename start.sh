#!/bin/bash

# Use the environmental variables passed to the Docker container and use them to:

# Configure the Database Connection
echo "- Copying config_default.php to /www/munkireport/config.php"
cp /www/munkireport/config_default.php /www/munkireport/config.php


# Fire up PHP and then start Nginx in non daemon mode so docker has something to keep running
echo ""
echo "*** Configuration of the Munki Report php file complete ***"
echo ""
echo "*** Starting php7-fpm ***"
service php7.0-fpm start
echo ""
echo "*** Starting NginX ***"
nginx