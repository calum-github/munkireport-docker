#!/bin/bash

# Use the environmental variables passed to the Docker container and use them to:

# Replace the server name with the FQDN/IP of the server and change the db name
echo "*** Setting DB Server to $DB_SERVER ***"
echo ""
echo "*** Setting DB Name to $DB_NAME ***"
echo ""
sed -i "/pdo_dsn/c\$conf['pdo_dsn'] = 'mysql:host=$DB_SERVER;dbname=$DB_NAME';" /www/munkireport/config.php

#  Replace the database user
echo "*** Setting DB User to $DB_USER ***"
echo ""
sed -i "/pdo_user/c\$conf['pdo_user'] = '$DB_USER';" /www/munkireport/config.php

# Replace the database user password
echo "*** Setting DB Password to $DB_PASS ***"
echo ""
sed -i "/pdo_pass/c\$conf['pdo_pass'] = '$DB_PASS';" /www/munkireport/config.php

# Replace the Munki Report Sitename
echo "*** Setting Munki Report Sitename to $MR_SITENAME ***"
echo ""
sed -i "/sitename/c\$conf['sitename'] = '$MR_SITENAME';" /www/munkireport/config.php

# Replace the Timezone
echo "*** Setting Timezone to $MR_TIMEZONE ***"
echo ""
sed -i "/timezone/c\$conf['timezone'] = @date_default_timezone_get($MR_TIMEZONE);" /www/munkireport/config.php

# Fire up PHP and then start Nginx in non daemon mode so docker has something to keep running
echo "*** Starting php5-fpm ***"
service php5-fpm restart
echo ""
echo "*** Starting NginX ***"
nginx