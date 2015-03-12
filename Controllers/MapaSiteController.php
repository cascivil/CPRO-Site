<?php

class MapaSite extends Controller
{

	function __construct () 
	{
		parent::__construct();
	}

	function index ()
	{
		$this->view->render('Shared/SiteMap', false);
	}
}


?>