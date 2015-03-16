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

abstract class PersistModelAbstract extends PDO
{
    /*
    * Vari�vel respons�vel por guardar dados da conex�o do banco
    * @var resource
    */
    protected $o_db;

    function __construct ()
    {
        // Database query string
        $st_dsn = DB_TYPE . ':host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8';

        echo $st_dsn;

        // Option string
        $st_option = array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES UTF8');

        // MySQL Connection
        $this->o_db = new PDO($st_dsn, DB_USER, DB_PASS, $st_option);

        // Set Attributes
        $this->o_db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }

    private function DatabaseBuild ()
    {

    }
}

?>