<?php

require '/Models/PublicacoesModel.php';

class Publicacoes extends Controller
{
	public $o_Publicacao;

	function __construct ()
	{
		parent::__construct();

		$this->o_Publicacao = new PublicacoesModel();

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

	function cadastrar ()
	{
		$this->view->render('Publicacoes/Cadastro', false);
	}

	function gravar ()
	{
		$return = $this->o_Publicacao->setImage();

		echo 'Retorno OK se 1 = ' . $return;

		if ($return)
		{
			$this->view->render('Publicacoes/Publicacao', false);
		}
		else
		{
			$this->view->render('Shared/Default', true);
		}
	}

	function exibir ($st_id = null)
	{
		if ($st_id)
		{
			$imagem = $this->o_Publicacao->getImage($st_id);
			$this->view->setParams(array('Imagem' => $imagem));
			$this->view->render('Publicacoes/Exibir', true);
		}
		else
		{
			$this->view->render('Home/Index', false);
		}
	}
}


?>