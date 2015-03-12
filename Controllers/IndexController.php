<?php

/*************************************************
 * Controlador que deverá ser chamado quando 
 * não for especificado nenhum outro.
 *
 * @package HyperSys
 * @author Felipe Souza
 *
 * Camada - Controladores ou Controllers
 * Diretório Pai - controllers 
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
}
?>