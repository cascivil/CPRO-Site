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


	function a2015 ($st_name = null)
	{
		if (!isset($st_name))
		{
			$this->view->render('Publicacoes/Index', false);
		}
		else
		{
			$this->view->render('Publicacoes/Publicacao', false);
		}
	}
}


?>