<?php

require_once 'Models/SetupModel.php';

class Setup extends Controller
{ 

	function __construct ()
	{
		parent::__construct();
	}

	function index ()
	{
		$this->view->setParams(array('Nome' => 'Teste'));
		$this->view->render('Shared/Default', true);
	}

	function criar ()
	{
		// Create Database
		$st_status = $_POST['selecao'];
		echo $st_status;
		
	}

}


?>