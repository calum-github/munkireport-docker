#!/bin/bash

# Use the environmental variables passed to the Docker container and use them to:

echo "- Starting php7-fpm ***"
service php7.2-fpm start
echo ""
echo "- Starting NginX ***"
nginx