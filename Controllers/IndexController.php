<?php

/*************************************************
 * Controlador que deverб ser chamado quando 
 * nгo for especificado nenhum outro.
 *
 * @package HyperSys
 * @author Felipe Souza
 *
 * Camada - Controladores ou Controllers
 * Diretуrio Pai - controllers 
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
  // Aзгo que deverб ser executada quando nenhuma outra for especificada, do mesmo jeito que o
  // arquivo index.html ou index.php й executado quando nenhum й referenciado
  public function indexAction ()
  {
    // Redirecionando para a pagina de lista de contatos
    header('Location: ?controle=Solucao&acao=listarSolucao');
  }
*/
}
?>