<?php

// Always provide a TRAILING SLASH (/) AFTER A PATH
define('URL', 'http://hom.cproengenharia.com.br:8081/');
define('SITE_PATH', 'C:/wamp/www/CPRO-Site/');
define('LIBS', 'Lib/');
define('CONTROLLER', 'Controllers/');
define('MODELS', 'Models/');

// Access to Database
define('DB_TYPE', 'pgsql');
define('DB_HOST', 'localhost');
define('DB_PORT', '5432');
define('DB_NAME', 'CProSite');
define('DB_USER', 'usrAppCPro');
define('DB_PASS', 'Sj6eA76Hf2Y4f56xG6BW');

// Debug mode
define('DEBUG', true);

// The sitewide hashkey, do not change this because its used for passwords!
// This is for other hash keys... Not sure yet
define('HASH_GENERAL_KEY', 'MixitUp200');

// This is for database passwords only
define('HASH_PASSWORD_KEY', 'catsFLYhigh2000miles');

?>