<?php

/*************************************************
 * First file to be executed.
 *
 * @package CPRO-Site
 * @author Felipe Souza
 *
 * Directory - Application Root
 * File - index.php
 ************************************************/

// Define system parameters
require 'config.php';
require SITE_PATH . 'Util/Auth.php';

// Setting PHP to show errors on screen
ini_set('display_errors', 1);

// Setting PHP to report every error
error_reporting(E_ALL);

// Loading config files
require_once SITE_PATH . LIBS . 'Application.php';

// Application start
$o_Application = new Application();
$o_Application->dispatch();

// Maintenance active (comment above instruction)
//$o_Application->manutencao();

?>