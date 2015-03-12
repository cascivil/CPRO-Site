<?php

/*************************************************
 * Responsável por gerenciar as soluções
 *
 * @package HyperSys
 * @author Felipe Souza
 *
 * Camada - Model
 * Diretório Pai - models
 * Arquivo - SolucaoModel.php
 ************************************************/

class SolucaoModel extends PersistModelAbstract
{
  private $in_id;
  private $in_nome;
  private $in_desc;
  private $in_status;

  function __construct()
  {
    parent::__construct();

    // Executa método de criação da tabela de Atividades
    $this->createTableSolucao();
  }

  // Setter e Getters da classe
  public function setId($in_id)
  {
    $this->in_id = $in_id;
    return $this;
  }
    
  public function getId()
  {
    return $this->in_id;
  }

  public function setNome($in_nome)
  {
    $this->in_nome = $in_nome;
    return $this;
  }
    
  public function getNome()
  {
    return $this->in_nome;
  }

  public function setDesc($in_desc)
  {
    $this->in_desc = $in_desc;
    return $this;
  }

  public function getDesc()
  {
    return $this->in_desc;
  }

  public function setStatus($in_status)
  {
    $this->in_status = $in_status;
    return $this;
  }

  public function getStatus()
  {
    return $this->in_status;
  }

  // Retorna a lista de Soluções
  public function _list($st_nome = null)
  {
    if(!is_null($st_nome))
    {
      $st_query = "SELECT * FROM Solution WHERE name LIKE '%$st_nome%';";
    }
    else
    {
      $st_query = 'SELECT * FROM Solution;';   
    }

    $v_solucoes = array();

    try
    {
      $o_data = $this->o_db->query($st_query);

      while($o_ret = $o_data->fetchObject())
      {
        $o_solucao = new SolucaoModel();
        $o_solucao->setId($o_ret->id);
        $o_solucao->setNome($o_ret->name);
        $o_solucao->setDesc($o_ret->desc);
        $o_solucao->setStatus($o_ret->status);
        array_push($v_solucoes, $o_solucao);
      }
    }
    catch(PDOException $e)
    {}

    return $v_solucoes;
  }

  // Retorna os dados de determinada Solução
  public function loadById( $in_id )
  {
    $st_query = "SELECT * FROM Solution WHERE id = $in_id;";
    try
    {
      $o_data = $this->o_db->query($st_query);
      $o_ret = $o_data->fetchObject();
      $this->setId($o_ret->id);
      $this->setNome($o_ret->name);
      $this->setDesc($o_ret->desc);
      $this->setStatus($o_ret->status);
      return $this;
    }
    catch(PDOException $e)
    {}
    return false;   
  }

  // Grava valores na tabela Solução
  public function save()
  {
    if(is_null($this->in_id))
    {
        $st_query = "INSERT INTO Solution
                    (
                      name,
                      description,
                      status
                    )
                    VALUES
                    (
                      '$this->in_nome',
                      '$this->in_desc',
                      TRUE
                    );";
    }
    else
    {
      $st_query = "UPDATE
                      Solution
                  SET
                      name = '$this->in_nome',
                      description = '$this->in_desc'
                      status = TRUE
                  WHERE
                      id = $this->in_id";
    }
    try
    {
      if($this->o_db->exec($st_query) > 0)
      {
        if(is_null($this->in_id))
        {
          return $this->o_db->lastInsertId();
        }
        else
        {
          return $this->in_id;
        }
      }
    }
    catch (PDOException $e)
    {
      throw $e;
    }
    return false;               
  }

  // Altera o status da Solução no Banco
  public function delete()
  {
    if(!is_null($this->in_id))
    {
      $st_query = "UPDATE Solution SET status=FALSE WHERE id = $this->in_id";

      if($this->o_db->exec($st_query) > 0)
      {
        return true;
      }
    }

    return false;
  }

  // Cria tabela para armazenar as Soluções
  private function createTableSolucao()
  {
    $st_query = "CREATE TABLE IF NOT EXISTS Solution
                (
                  id INTEGER NOT NULL AUTO_INCREMENT,
                  name VARCHAR(50) NOT NULL,
                  desc VARCHAR(500),
                  status BOOLEAN NOT NULL,
                  PRIMARY KEY (id)
                ) ENGINE = INNODB;";

    //executando a query;
    try
    {
      $this->o_db->exec($st_query);
    }
    catch(PDOException $e)
    {
      throw $e;
    }
  }
}
?>