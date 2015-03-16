<?php

/*************************************************
 * Default controller.
 *
 * @package CPRO-Site
 * @author Felipe Souza
 *
 * Layer - Controllers
 * Directory - Controllers
 * File - IndexController.php
 ************************************************/

class Index extends Controller
{
	function __construct ()
	{
		parent::__construct();
	}

	function index ()
	{
		$this->view->render('Home/Index', false);
	}
}

?>