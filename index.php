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
  require 'Util/Auth.php';

  // Configurando o PHP para mostrar os erros na tela
  ini_set('display_errors', 1);

  // Configurando o PHP para reportar todo e qualquer erro
  error_reporting(E_ALL);

/*
  require_once 'lib/Application.php';
  $o_Application = new Application();
  $o_Application->dispatch();
*/

  // Loading config files
  require 'Lib/Dispatcher.php';
  require 'Lib/Controller.php';
  require 'Lib/View.php';

  function __autoload($class)
  {
    require LIBS . $class . '.php';
  }

 // $app = new Dispatcher();

  // Application start
  $o_Application = new Application();
  $o_Application->dispatch();

?>

