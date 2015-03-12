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
}
?>