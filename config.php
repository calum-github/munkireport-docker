<?php if ( ! defined( 'KISS' ) ) exit;

$conf['index_page'] = 'index.php?';
$conf['sitename'] = 'MunkiReport';
$conf['vnc_link'] = "vnc://%s:5900";
$conf['ssh_link'] = "ssh://adminuser@%s";
$conf['allow_migrations'] = TRUE;
$conf['apps_to_track'] = array('Firefox','Java','Flash Player');
	
	/*
	|===============================================
	| Authentication
	|===============================================
	|
	| Currently four authentication methods are supported:
	|
	|	1) Don't require any authentication: paste the following line in your config.php
	|			$conf['auth']['auth_noauth'] = array();
	|
	|	2) (default) Local accounts: visit /index.php?/auth/generate and paste
	|	   the result in your config.php
	|
	|	3) LDAP:
	|		At least fill in these items:
	|		$conf['auth']['auth_ldap']['server']      = 'ldap.server.local'; // One or more servers separated by commas.
	|		$conf['auth']['auth_ldap']['usertree']    = 'uid=%{user},cn=users,dc=server,dc=local'; // Where to find the user accounts.
	|		$conf['auth']['auth_ldap']['grouptree']   = 'cn=groups,dc=server,dc=local'; // Where to find the groups.
	|		$conf['auth']['auth_ldap']['mr_allowed_users'] = array('user1','user2'); // For user based access, fill in users.
	|		$conf['auth']['auth_ldap']['mr_allowed_groups'] = array('group1','group2'); // For group based access, fill in groups.
	|
	|		Optional items:
	|		$default_conf['userfilter']  = '(&(uid=%{user})(objectClass=posixAccount))'; // LDAP filter to search for user accounts.
	|		$default_conf['groupfilter'] = '(&(objectClass=posixGroup)(memberUID=%{uid}))'; // LDAP filter to search for groups.
	|		$conf['auth']['auth_ldap']['port']        = 389; // LDAP port.
	|		$conf['auth']['auth_ldap']['version']     = 3; // Use LDAP version 1, 2 or 3.
	|		$conf['auth']['auth_ldap']['starttls']    = FALSE; // Set to TRUE to use TLS.
	|		$conf['auth']['auth_ldap']['referrals']   = FALSE; // Set to TRUE to follow referrals.
	|		$conf['auth']['auth_ldap']['deref']       = LDAP_DEREF_NEVER; // How to dereference aliases. See http://php.net/ldap_search
	|		$conf['auth']['auth_ldap']['binddn']      = ''; // Optional bind DN
	|		$conf['auth']['auth_ldap']['bindpw']      = ''; // Optional bind password
	|		$conf['auth']['auth_ldap']['userscope']   = 'sub'; // Limit search scope to sub, one or base.
	|		$conf['auth']['auth_ldap']['groupscope']  = 'sub'; // Limit search scope to sub, one or base.
	|		$conf['auth']['auth_ldap']['groupkey']    = 'cn'; // The key that is used to determine group membership
	|		$conf['auth']['auth_ldap']['debug']       = 0; // Set to TRUE to debug LDAP.
	|
	|	4) Active Directory: fill the needed and include the lines in your config.php.
	|		 e.g.
	|		$conf['auth']['auth_AD']['account_suffix'] = '@mydomain.local';
	|		$conf['auth']['auth_AD']['base_dn'] = 'DC=mydomain,DC=local'; //set to NULL to auto-detect
	|		$conf['auth']['auth_AD']['domain_controllers'] = array('dc01.mydomain.local'); //can be an array of servers
	|		$conf['auth']['auth_AD']['admin_username'] = NULL; //if needed to perform the search
	|		$conf['auth']['auth_AD']['admin_password'] = NULL; //if needed to perform the search
	|		$conf['auth']['auth_AD']['mr_allowed_users'] = array('macadmin','bossman');
	|		$conf['auth']['auth_AD']['mr_allowed_groups'] = array('AD Group 1','AD Group 2'); //case sensitive
	|
	| Authentication methods are checked in the order that they appear above. Not in the order of your
	| config.php!. You can combine methods 2, 3 and 4
	|
	*/
$auth_config['root'] = '$P$BUqxGuzR2VfbSvOtjxlwsHTLIMTmuw0'; // Password is root
	
	/*
	|===============================================
	| Role Based Authorization
	|===============================================
	|
	| Authorize actions by listing roles appropriate array.
	| Don't change these unless you know what you're doing, these roles are
	| also used by the Business Units
	|
	*/
$conf['authorization']['delete_machine'] = array('admin', 'manager');
$conf['authorization']['global'] = array('admin');

    /*
	|===============================================
	| Roles
	|===============================================
	|
	| Add users or groups to the appropriate roles array.
	|
	*/
$conf['roles']['admin'] = array('*');

	/*
	|===============================================
	| Local groups
	|===============================================
	|
	| Create local groups, add users to groups.
	|
	*/
	//$conf['groups']['admin_users'] = array();

	/*
	|===============================================
	| Business Units
	|===============================================
	|
	| Set to TRUE to enable Business Units
	| For more information, see docs/business_units.md
	|
	*/
$conf['enable_business_units'] = FALSE;

	/*
	|===============================================
	| Force secure connection when authenticating
	|===============================================
	|
	| Set this value to TRUE to force https when logging in.
	| This is useful for sites that serve MR both via http and https
	|
	*/
$conf['auth_secure'] = FALSE;

	/*
	|===============================================
	| Inventory - bundle ignore list
	|===============================================
	|
	| List of bundle-id's to be ignored when processing inventory
	| The list is processed using regex, examples:
	|
	| Skip  all virtual windows apps created by parallels and VMware
	| $conf['bundleid_ignorelist'][] = array('com.parallels.winapp.*', 'com.vmware.proxyApp.*');
	|
	| Skip all Apple apps, except iLife, iWork and Server
	| 'com.apple.(?!iPhoto)(?!iWork)(?!Aperture)(?!iDVD)(?!garageband)(?!iMovieApp)(?!Server).*'
	|
	| Skip all apps with empty bundle-id's
	| '^$'
	|
	*/
$conf['bundleid_ignorelist'][] = 'com.parallels.winapp.*';
$conf['bundleid_ignorelist'][] = 'com.vmware.proxyApp.*';

	/*
	|===============================================
	| Inventory - path ignore list
	|===============================================
	|
	| List of bundle-paths to be ignored when processing inventory
	| The list is processed using regex, examples:
	|
	| Skip all apps in /System/Library
	| $conf['bundlepath_ignorelist'][] = '/System/Library/.*';
	|
	| Skip all apps that are contained in an app bundle
	| $conf['bundlepath_ignorelist'][] = '.*\.app\/.*\.app'
	|
	*/
$conf['bundlepath_ignorelist'] = array('/System/Library/.*');

	/*
	|===============================================
	| Modules
	|===============================================
	|
	| List of modules that have to be installed on the client
	| See for possible values the names of the directories
	| in app/modules/
	| e.g. $conf['modules'] = array('disk_report', 'inventory');
	|
	| An empty list installs only the basic reporting modules:
	| Machine and Reportdata
	|
	*/
$conf['modules'] = array('munkireport');

	/*
	|===============================================
	| PDO Datasource
	|===============================================
	|
	| Specify dsn, username, password and options
	| Supported engines: sqlite and mysql
	| Mysql example:
	|
	*/
$conf['pdo_dsn'] = 'mysql:host=sql.test.internal;dbname=munkireport';
$conf['pdo_user'] = 'admin';
$conf['pdo_pass'] = 'admin';
$conf['pdo_opts'] = array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8');
	
	/*
	|===============================================
	| Proxy settings
	|===============================================
	|
	| If you are behind a proxy, MunkiReport may be unable to
	| retrieve warranty and model information from Apple.
	|
	| Note that there is only authenticated proxy support for
	| basic authentication
	|
	*/
    //$conf['proxy']['server'] = 'proxy.yoursite.org'; // Required
	//$conf['proxy']['username'] = 'proxyuser'; // Optional
	//$conf['proxy']['password'] = 'proxypassword'; Optional
	//$conf['proxy']['port'] = 8080; // Optional, defaults to 8080

	/*
	|===============================================
	| Request timeout
	|===============================================
	|
	| Timeout for retrieving warranty and model information from Apple.
	|
	| Timeout in seconds
	|
	*/
$conf['request_timeout'] = 5;

	/*
	|===============================================
	| Create table options
	|===============================================
	|
	| For MySQL, define the default table and charset
	|
	*/
$conf['mysql_create_tbl_opts'] = 'ENGINE=InnoDB DEFAULT CHARSET=utf8';

	/*
	|===============================================
	| Timezone
	|===============================================
	|
	| See http://www.php.net/manual/en/timezones.php for valid values
	|
	*/
$conf['timezone'] = @date_default_timezone_get(Australia/Sydney);

$conf['debug'] = FALSE;