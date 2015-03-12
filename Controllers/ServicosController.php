<?php

	class Servicos extends Controller
	{

		function __construct() {
			parent::__construct();

    		$this->view->render('Servicos/Index', false);
		}


	}


?>