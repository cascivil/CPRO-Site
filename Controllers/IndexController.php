<?php

/*************************************************
 * Controlador que dever� ser chamado quando 
 * n�o for especificado nenhum outro.
 *
 * @package HyperSys
 * @author Felipe Souza
 *
 * Camada - Controladores ou Controllers
 * Diret�rio Pai - controllers 
 * Arquivo - IndexController.php
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


/*
  // A��o que dever� ser executada quando nenhuma outra for especificada, do mesmo jeito que o
  // arquivo index.html ou index.php � executado quando nenhum � referenciado
  public function indexAction ()
  {
    // Redirecionando para a pagina de lista de contatos
    header('Location: ?controle=Solucao&acao=listarSolucao');
  }
*/
}
?>