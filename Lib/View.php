<?php

/*************************************************
 * Essa classe � respons�vel por renderizar os
 * arquivos HTML
 *
 * @package HyperSys
 * @author Felipe Souza
 *
 * Diret�rio Pai - lib
 * Arquivo - View.php
 ************************************************/

class View
{

	/*
	* Armazena o conte�do HTML
	* @var string
	*/
	private $st_contents;

	/*
	* Armazena o nome do arquivo de visualiza��o
	* @var string
	*/
	private $st_view;

	/*
	* Armazena os dados que devem ser mostrados ao reenderizar o
	* arquivo de visualiza��o
	* @var Array
	*/
	private $v_params;

	/*
	* � possivel efetuar a parametriza��o do objeto ao instanciar o mesmo,
	* $st_view � o nome do arquivo de visualiza��o a ser usado e
	* $v_params s�o os dados que devem ser utilizados pela camada de visualiza��o
	*
	* @param string $st_view
	* @param Array $v_params
	*/
	function __construct ($st_view = null, $v_params = null)
	{
		$this->st_view = $st_view;
		$this->v_params = $v_params;
	}

	/*
	* Define qual arquivo html deve ser renderizado
	* @param string $st_view
	* @throws Exception
	*/
	public function setView ($st_view)
	{
		if (file_exists($st_view))
		{
			$this->st_view = $st_view;
		}
		else
		{
	    	throw new Exception("View File '$st_view' don't exists");
		}
	}

	/*
	* Retorna o nome do arquivo que deve ser renderizado
	* @return string
	*/
	public function getView()
	{
	  return $this->st_view;
	}

	/*
	* Define os dados que devem ser repassados � view
	* @param Array $v_params
	*/
	public function setParams(Array $v_params)
	{
	  $this->v_params = $v_params;
	}

	/*
	* Retorna os dados que foram ser repassados ao arquivo de visualiza��o
	* @return Array
	*/
	public function getParams()
	{
	    return $this->v_params;
	}


	public function render ($st_view, $noInclude = false)
	{
		if ($noInclude == false)
		{
			require 'Views/Shared/Header.phtml';
			require 'Views/' . $st_view . '.phtml';
			require 'Views/Shared/Footer.phtml';
		}
		else
		{
			require 'Views/' . $st_view . '.phtml';
		}
	}


	/*
	* Retorna uma string contendo todo
	* o conteudo do arquivo de visualizav�v�o
	*
	* @return string
	*/
	public function getContents()
	{
	    ob_start();
	    if(isset($this->st_view))
	        require_once $this->st_view;
	    $this->st_contents = ob_get_contents();
	    ob_end_clean();
	    return $this->st_contents;
	}

	// Imprime o arquivo de visualiza��o
	public function showContents()
	{
	  echo $this->getContents();
	  exit;
	}



}

?>