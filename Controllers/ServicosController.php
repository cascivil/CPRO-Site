<?php

class Servicos extends Controller
{

	function __construct ()
	{
		parent::__construct();
	}

	function index ()
	{
		$this->view->render('Servicos/Index', false);
	}
}

?>