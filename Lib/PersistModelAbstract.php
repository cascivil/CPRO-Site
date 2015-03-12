<?php

/*************************************************
 * Classe Abstrata responsável por centralizar
 * a conexãocom o banco de dados
 *
 * @package HyperSys
 * @author Felipe Souza
 *
 * Diretório Pai - lib
 * Arquivo - PersistModelAbstract.php
 ************************************************/

abstract class PersistModelAbstract
{
  /*
  * Variável responsável por guardar dados da conexão do banco
  * @var resource
  */
  protected $o_db;

  function __construct()
  {
    // Inicio de conexão com MySQL
    $st_host = 'localhost';
    $st_banco = 'HyperSys';
    $st_usuario = 'admin';
    $st_senha = 'osk5912';

    $st_dsn = "mysql:host=$st_host;dbname=$st_banco";

    $this->o_db = new PDO($st_dsn, $st_usuario, $st_senha);
  }
}

?>