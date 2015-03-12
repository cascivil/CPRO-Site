<?php

/*************************************************
 * Controlador da aplica��o
 *
 * @package CPRO-Site
 * @author Felipe Souza
 *
 * Diret�rio Pai - Lib 
 * Arquivo - IndexController.php
 ************************************************/


// Load classes from Lib folder
function __autoload ($st_class)
{
  if (file_exists('Lib/' . $st_class . '.php'))
  {
    require_once 'Lib/' . $st_class . '.php';
  }
}

/*
* Verifica qual classe controlador (Controller) o usu�rio deseja chamar
* e qual m�todo dessa classe (Action) deseja executar.
* Caso o controlador (controller) n�o seja especificado, o IndexControllers ser� o padr�o
* Caso o m�todo (Action) n�o seja especificado, o indexAction ser� o padr�o
* 
**/
class Application
{
    /*
    * Usada pra guardar o nome da classe
    * de controle (Controller) a ser executada
    * @var string
    */
    protected $st_controller;

    /*
    * Usada para guardar o nome do metodo da
    * classe de controle (Controller) que dever� ser executado
    * @var string
    */
    protected $st_action;
  
    /*
    * Verifica se os par�metros de controlador (Controller) e a��o (Action) foram
    * passados via par�metros "Post" ou "Get" e os carrega tais dados
    * nos respectivos atributos da classe
    */
    private function loadRoute()
    {
      /*
      * Se o controller nao for passado por GET,
      * assume-se como padr�o o controller 'IndexController';
      */
      $this->st_controller = isset($_REQUEST['controle']) ? $_REQUEST['controle'] : 'Index';

      /*
      * Se a action nao for passada por GET,
      * assume-se como padr�o a action 'IndexAction';
      */
      $this->st_action = isset($_REQUEST['acao']) ? $_REQUEST['acao'] : 'index';




      $url = isset($_GET['url']) ? $_GET['url'] : null;
      $url = strtolower(rtrim($url, '/'));
      $url = explode('/', $url);

      print_r($url);

      if (empty($url[0]))
      {
          require 'Controllers/IndexController.php';
          $controller = new Index();
          return false;
      }

      $file = 'Controllers/' . ucfirst($url[0]) . 'Controller.php';

      if (file_exists($file))
      {
          require $file;
      }
      else
      {
          require 'Controllers/ErrorController.php';
          $controller = new Error();
          return false;
      }

      $controllerName = ucfirst($url[0]);
      $controller = new $controllerName;






    }
  
    /*
    * Instancia classe referente ao Controlador (Controller) e executa
    * m�todo referente e  acao (Action)
    * @throws Exception
    */
    public function dispatch()
    {
        $this->loadRoute();
  
        // Verificando se o arquivo de controle existe
        $st_controller_file = 'Controllers/' . $this->st_controller . 'Controller.php';

        if (file_exists($st_controller_file))
            require_once $st_controller_file;
        else
            throw new Exception('Arquivo '.$st_controller_file.' n�o encontrado');
  
        //verificando se a classe existe
        $st_class = $this->st_controller.'Controller';

        if (class_exists($st_class))
            $o_class = new $st_class;
        else
            throw new Exception("Classe '$st_class' n�o existe no arquivo '$st_controller_file'");
  
        //verificando se o metodo existe
        $st_method = $this->st_action.'Action';
        if(method_exists($o_class,$st_method))
            $o_class->$st_method();
        else
            throw new Exception("Metodo '$st_method' n�o existe na classe $st_class'");
    }

    /*
    * Redireciona a chamada http para outra p�gina
    * @param string $st_uri
    */
    static function redirect($st_uri)
    {
        header("Location: $st_uri");
    }
}
?>