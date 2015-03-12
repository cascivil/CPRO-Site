<?php

	/**
	* Configuração das rotas do sistema.
	*/
	class Dispatcher
	{

		function __construct ()
		{
			$url = isset($_GET['url']) ? $_GET['url'] : null;
			$url = strtolower(rtrim($url, '/'));
			$url = explode('/', $url);

			print_r($url);

			if (empty($url[0]))
			{
				require 'Controllers/IndexController.php';
				$controller = new Index();
				return false;
			}

			$file = 'Controllers/' . ucfirst($url[0]) . 'Controller.php';

			if (file_exists($file))
			{
				require $file;
			}
			else
			{
				require 'Controllers/ErrorController.php';
				$controller = new Error();
				return false;
			}

			$controllerName = ucfirst($url[0]);
			$controller = new $controllerName;
		}
	}


?>