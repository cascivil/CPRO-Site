<?php

// Incluindo classes da camada Model
require_once 'models/SolucaoModel.php';

/*************************************************
 * Router configs
 *
 * @package CPRO-Site
 * @author Felipe Souza
 *
 * Layer - Controladores ou Controllers
 * Directory - Controllers
 * File - SolucaoController.php
 ************************************************/

class SolucaoController
{
  /**
  * Efetua a manipulação dos modelos necessários
  * para a aprensentação da lista de soluções
  */
  public function listarSolucaoAction()
  {
    $o_solucao = new SolucaoModel();

    // Listando os soluções cadastradas
    $v_solucao = $o_solucao->_list();

    // Definindo qual o arquivo HTML que será usado para mostrar a lista de soluções
    $o_view = new View('views/visualizarSolucao.phtml');

    //Passando os dados do contato para a View
    $o_view->setParams(array('v_solucao' => $v_solucao));

    //Imprimindo código HTML
    $o_view->showContents();
  }

  // Gerencia a requisiçães de criação e edição dos contatos 
  public function manterContatoAction()
  {
    $o_solucao = new ContatoModel();

    //verificando se o id do contato foi passado
    if( isset($_REQUEST['in_con']) )
        //verificando se o id passado é valido
        if( DataValidator::isNumeric($_REQUEST['in_con']) )
            //buscando dados do contato
            $o_solucao->loadById($_REQUEST['in_con']);
          
    if(count($_POST) > 0)
    {
        $o_solucao->setNome(DataFilter::cleanString($_POST['st_nome']));
        $o_solucao->setEmail(DataFilter::cleanString($_POST['st_email']));
          
        //salvando dados e redirecionando para a lista de contatos
        if($o_solucao->save() > 0)
            Application::redirect('?controle=Contato&acao=listarContato');
    }
          
    $o_view = new View('views/manterContato.phtml');
    $o_view->setParams(array('o_solucao' => $o_solucao));
    $o_view->showContents();
  }

  /**
  * Gerencia a requisições de exclusão dos contatos
  */
  public function apagarContatoAction()
  {
      if( DataValidator::isNumeric($_GET['in_con']) )
      {
          //apagando o contato
          $o_solucao = new ContatoModel();
          $o_solucao->loadById($_GET['in_con']);
          $o_solucao->delete();
            
          //Apagando os telefones do contato
          $o_telefone = new TelefoneModel();
          $v_telefone = $o_telefone->_list($_GET['in_con']);
          foreach($v_telefone AS $o_telefone)
              $o_telefone->delete();
          Application::redirect('?controle=Contato&acao=listarContato');
      }   
  }
}
?>