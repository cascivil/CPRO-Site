<?php

class Publicacoes extends Controller
{

	function __construct ()
	{
		parent::__construct();

	}

	function index ()
	{
		$this->view->render('Publicacoes/Index', false);
	}
}


?>