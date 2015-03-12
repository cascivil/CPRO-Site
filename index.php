<?php

/*************************************************
 * Primeiro arquivo a ser executado.
 *
 * @package HyperSys
 * @author Felipe Souza
 *
 * Diretório Pai - Raiz do site
 * Arquivo - index.php
 ************************************************/

  // Adicionando variáveis de sistema
  require 'config.php';
  require SITE_PATH . 'Util/Auth.php';

  // Configurando o PHP para mostrar os erros na tela
  ini_set('display_errors', 1);

  // Configurando o PHP para reportar todo e qualquer erro
  error_reporting(E_ALL);

  // Loading config files
  require_once SITE_PATH . LIBS . 'Application.php';

  // Application start
  $o_Application = new Application();
  $o_Application->dispatch();
?>

