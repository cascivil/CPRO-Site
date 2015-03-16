<?php

class Sobre extends Controller
{

	function __construct ()
	{
		parent::__construct();
	}

	function index ()
	{
		$this->view->render('Sobre/Index', false);
	}

	function curriculo ($st_name = null)
	{
		if (!isset($st_name))
		{
			$this->view->render('Sobre/Index', false);
		}
		else
		{
			$st_name = explode('-', $st_name);
			$st_name = ucfirst($st_name[0]) . ' ' . ucfirst($st_name[1]);
			$this->view->setParams(array('Nome' => $st_name));
			$this->view->render('Sobre/Curriculo', false);
		}
	}
}

?>