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

abstract class PersistModelAbstract extends PDO
{
	/*
	* Variável responsável por guardar dados da conexão do banco
	* @var resource
	*/
	protected $o_db;

	function __construct ()
	{
		// Database query string
		$st_dsn = DB_TYPE . ':host=' . DB_HOST . ';port=' . DB_PORT . ';dbname=' . DB_NAME; // . ';'; //user=' . DB_USER . ';password=' . DB_PASS;

		// Option string
		$st_option = array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES UTF8');

		// MySQL Connection
		try
		{
			$this->o_db = new PDO($st_dsn, DB_USER, DB_PASS, $st_option);

			// Set Attributes
			$this->o_db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
		}
		catch (PDOException $e)
		{
			echo 'Error: ' . $e->getMessage();
			throw new Exception("Error Processing Request", 1);
			exit;
		}
	}

	private function DatabaseBuild ()
	{
		try
		{
			$this->o_db->query('hi');
		}
		catch (PDOException $ex)
		{
			echo "An Error occured!";
			some_logging_function($ex->getMessage());
		}


	}
}

?>