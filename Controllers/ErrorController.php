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
}

?>