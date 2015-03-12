<?php

// Always provide a TRAILING SLASH (/) AFTER A PATH
define('URL', 'http://hom.cproengenharia.com.br:8080/');
define('LIBS', 'Lib/');

// Access to Database
define('DB_TYPE', 'mysql');
define('DB_HOST', 'localhost');
define('DB_NAME', 'CProSite');
define('DB_USER', 'usrAppCpro');
define('DB_PASS', '');

// Debug mode
define('DEBUG', true);

// The sitewide hashkey, do not change this because its used for passwords!
// This is for other hash keys... Not sure yet
define('HASH_GENERAL_KEY', 'MixitUp200');

// This is for database passwords only
define('HASH_PASSWORD_KEY', 'catsFLYhigh2000miles');

?>