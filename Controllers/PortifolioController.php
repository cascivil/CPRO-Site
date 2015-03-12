<?php

class Portifolio extends Controller
{

	function __construct ()
	{
		parent::__construct();
	}

	function index ()
	{
		$this->view->render('Portifolio/Index', false);
	}

}

?>