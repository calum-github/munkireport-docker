#!/bin/bash

# Use the environmental variables passed to the Docker container and use them to:

# Configure the Database Connection
echo "*** Setting DB Server to $DB_SERVER ***" 
echo ""
echo "*** Setting DB Name to $DB_NAME ***"
echo ""
sed -i "/pdo_dsn/c\$conf['pdo_dsn'] = 'mysql:host=$DB_SERVER;dbname=$DB_NAME';" /www/munkireport/config.php # Set the DB Name and Server Address
echo "*** Setting DB User to $DB_USER ***"
echo ""
sed -i "/pdo_user/c\$conf['pdo_user'] = '$DB_USER';" /www/munkireport/config.php # Set the DB User
echo "*** Setting DB Password to $DB_PASS ***"
echo ""
sed -i "/pdo_pass/c\$conf['pdo_pass'] = '$DB_PASS';" /www/munkireport/config.php # Set the DB Password

# Configure MR settings
echo "*** Setting Munki Report Sitename to $MR_SITENAME ***"
echo ""
sed -i "/sitename/c\$conf['sitename'] = '$MR_SITENAME';" /www/munkireport/config.php # Set the MR Site Name
echo "*** Setting Timezone to $MR_TIMEZONE ***"
echo ""
sed -i "/timezone/c\$conf['timezone'] = @date_default_timezone_get($MR_TIMEZONE);" /www/munkireport/config.php # Set the MR Timezone

# Check to see which type of proxy server config we need
if [ "$proxy_required" = "mod1" ];
	then
# Configure Proxy Settings for Warranty Lookups etc 
echo "*** Proxy Server Mode 1 (Only server and port number) selected ***"
echo ""
echo "*** Setting Proxy server to $proxy_server ***"
echo ""
sed -i "/proxy.yoursite.org/c\$conf['proxy']['server'] = '$proxy_server';" /www/munkireport/config.php # Set the proxy server address
echo "*** Setting Proxy port to $proxy_port ***"
echo ""
sed -i "/8080/c\$conf['proxy']['port'] = 8080;" /www/munkireport/config.php # Set the proxy port

elif [ "$proxy_required" = "mod2" ];
	then
echo "*** Proxy Server Mode 2 (authenticated proxy) selected ***"
echo ""
echo "*** Setting Proxy server to $proxy_server ***"
echo ""
sed -i "/proxy.yoursite.org/c\$conf['proxy']['server'] = '$proxy_server';" /www/munkireport/config.php # Set the proxy server address
echo "*** Setting Proxy port to $proxy_port ***"
echo ""
sed -i "/8080/c\$conf['proxy']['port'] = 8080;" /www/munkireport/config.php # Set the proxy port
echo "*** Setting Proxy username to $proxy_uname ***"
echo ""
sed -i "/proxyuser/c\$conf['proxy']['username'] = '$proxy_uname';" /www/munkireport/config.php # set the proxy username
echo "*** Setting Proxy password to $proxy_pword ***"
echo ""
sed -i "/proxypassword/c\$conf['proxy']['password'] = '$proxy_pword';" /www/munkireport/config.php # set the proxy password

elif [ "$proxy_required" = "no" ]; 
	then
	echo "*** Proxy server settings are not required, skipping ***"
fi


# Fire up PHP and then start Nginx in non daemon mode so docker has something to keep running
echo ""
echo "*** Configuration of the Munki Report php file complete ***"
echo ""
echo "*** Starting php5-fpm ***"
service php5-fpm restart
echo ""
echo "*** Starting NginX ***"
nginx