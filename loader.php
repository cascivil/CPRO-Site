<?php

// Evita que usuários acesse este arquivo diretamente
if ( ! defined('ABSPATH')) exit;
 
// Inicia a sessão
session_start ();
 
// Verify Debug Mode
if ( ! defined('DEBUG') || DEBUG === false ) 
{
	// Esconde todos os erros
	ini_set("display_errors", 0);
	error_reporting(0);
}
else
{
	// Mostra todos os erros
	ini_set("display_errors", 1);
	error_reporting(E_ALL);
}

// Funções globais
require_once ABSPATH . '/functions/global-functions.php';
 
// Carrega a aplicação
$tutsup_mvc = new TutsupMVC();

?>