<?php

/*************************************************
 * Application controller (routers)
 *
 * @package CPRO-Site
 * @author Felipe Souza
 *
 * Directory - Lib
 * File - IndexController.php
 ************************************************/

// Load classes from Lib folder
function __autoload ($st_class)
{
	if (file_exists(SITE_PATH . LIBS . $st_class . '.php'))
	{
		require_once SITE_PATH . LIBS . $st_class . '.php';
	}
}

/*
* Verifica qual classe controlador (Controller) o usuário deseja chamar
* e qual método dessa classe (Action) deseja executar.
* Caso o controlador (controller) não seja especificado, o IndexControllers será o padrão
* Caso o método (Action) não seja especificado, o indexAction será o padrão
*
**/
class Application
{
	/*
	* Usada pra guardar o nome da classe
	* de controle (Controller) a ser executada
	* @var string
	*/
	protected $st_controller;

	/*
	* Usada para guardar o nome do metodo da
	* classe de controle (Controller) que deverá ser executado
	* @var string
	*/
	protected $st_action;

	/*
	* Usada para guardar os parâmetros necessários ao metodo da
	* classe de controle que deverá ser executado
	* @var string
	*/
	protected $st_parameters;

	/*
	* Verifica se os parâmetros de controlador (Controller) e ação (Action) foram
	* passados via parâmetros "Post" ou "Get" e os carrega tais dados
	* nos respectivos atributos da classe
	*/
	private function loadRoute()
	{
		$url = isset($_GET['url']) ? $_GET['url'] : null;
		$url = strtolower(rtrim($url, '/'));
		$url = explode('/', $url);

		$this->st_controller = !empty($url[0]) ? ucfirst($url[0]) : 'Index';

		//echo $this->st_controller;

		if (strpos($this->st_controller, '-'))
		{
			$this->st_controller = explode('-', $this->st_controller);
			$this->st_controller = $this->st_controller[0] . ucfirst($this->st_controller[1]);
		}

		$this->st_action = !empty($url[1]) ? $url[1] : 'index';

		if (strpos($this->st_action, '-'))
		{
			$this->st_action = explode('-', $this->st_action);
			$this->st_action = $this->st_action[0] . ucfirst($this->st_action[1]);
		}

		$length = count($url);

		if ($length > 2)
		{
			$this->st_parameters = $url[2];

			for ($i=3; $i < $length; $i++)
			{
				$this->st_parameters .= ', ' . $url[$i];
			}
		}
		else
		{
			empty($this->st_parameters);
		}
	}

	/*
	* Instancia classe referente ao Controlador (Controller) e executa
	* método referente e  acao (Action)
	* @throws Exception
	*/
	public function dispatch()
	{
		$this->loadRoute();

		// Controller exists
		$st_controller_file = CONTROLLER . $this->st_controller . 'Controller.php';

		if (file_exists($st_controller_file))
		{
			require_once $st_controller_file;
		}
		else
		{
			throw new Exception('Arquivo '.$st_controller_file.' não encontrado');
		}

		// Class exists
		$st_class = $this->st_controller;

		if (class_exists($st_class))
		{
			$o_class = new $st_class;
		}
		else
		{
			throw new Exception("Classe '$st_class' não existe no arquivo '$st_controller_file'");
		}

		// Method exists
		$st_method = $this->st_action;

		if (method_exists($o_class, $st_method))
		{
			// Call method without parameters
			$o_class->$st_method($this->st_parameters);
		}
		else
		{
			throw new Exception("Metodo '$st_method' não existe na classe $st_class'");
		}
	}

	public function error ()
	{
		require CONTROLLER . 'ErrorController.php';

		$this->_controller = new Error();
		$this->_controller->index();
		exit;
	}

	// Maintenance config
	public function manutencao ()
	{
		require CONTROLLER . 'ErrorController.php';

		$this->_controller = new Error();
		$this->_controller->manutencao();
	}

	/*
	* Redireciona a chamada http para outra página
	* @param string $st_uri
	*/
	static function redirect($st_uri)
	{
		header("Location: $st_uri");
	}
}

?>