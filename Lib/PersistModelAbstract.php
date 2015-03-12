<?php

/*************************************************
 * Classe Abstrata respons�vel por centralizar
 * a conex�ocom o banco de dados
 *
 * @package HyperSys
 * @author Felipe Souza
 *
 * Diret�rio Pai - lib
 * Arquivo - PersistModelAbstract.php
 ************************************************/

abstract class PersistModelAbstract
{
  /*
  * Vari�vel respons�vel por guardar dados da conex�o do banco
  * @var resource
  */
  protected $o_db;

  function __construct()
  {
    // Inicio de conex�o com MySQL
    $st_host = 'localhost';
    $st_banco = 'HyperSys';
    $st_usuario = 'admin';
    $st_senha = 'osk5912';

    $st_dsn = "mysql:host=$st_host;dbname=$st_banco";

    $this->o_db = new PDO($st_dsn, $st_usuario, $st_senha);
  }
}

?>