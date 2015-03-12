<?php

class Cases extends Controller
{

	function __construct ()
	{
		parent::__construct();
	}

	function index ()
	{
		$this->view->render('Cases/Index', false);
	}

}

?>