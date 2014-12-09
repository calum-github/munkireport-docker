#!/bin/bash

# Use the environmental variables passed to the Docker container and use them to:

# Replace the server name with the FQDN/IP of the server and change the db bane
sed -i "/pdo_dsn/c\$conf['pdo_dsn'] = 'mysql:host=$DB_SERVER;dbname=$DB_NAME';" /www/munkireport/config.php

#  Replace the database user
sed -i "/pdo_user/c\$conf['pdo_user'] = '$DB_USER';" /www/munkireport/config.php

# Replace the database user password
sed -i "/pdo_pass/c\$conf['pdo_pass'] = '$DB_PASS';" /www/munkireport/config.php

# Replace the Munki Report Sitename
sed -i "/sitename/c\$conf['sitename'] = '$MR_SITENAME';" /www/munkireport/config.php

# Replace the Timezone
sed -i "/timezone/c\$conf['timezone'] = @date_default_timezone_get($MR_TIMEZONE);" /www/munkireport/config.php

# Fire up PHP and then start Nginx in non daemon mode so docker has something to keep running
service php5-fmp restart && nginx