<?php

/**
* 
*/

class Error extends Controller
{
	function __construct ()
	{
		parent::__construct();
	}

	function index ()
	{
		$this->view->render('Error/Error404', false);
	}

	function Error404 ()
	{
		$this->view->render('Error/Error404', false);
	}

	function Error500 ()
	{
		$this->view->render('Error/Error500', false);
	}

	function Manutencao ()
	{
		$this->view->render('Error/Manutencao', true);
	}
}

?>