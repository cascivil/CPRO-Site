
<?php

/*************************************************
 * Publications manager
 *
 * @package CPRO-Site
 * @author Felipe Souza
 *
 * Layer - Model
 * Directory - Models
 * File - PublicacoesModel.php
 ************************************************/

class PublicacoesModel extends PersistModelAbstract
{
	private $f_image;

  private $in_id;
  private $in_nome;
  private $in_desc;
  private $in_solucao;
  private $in_produto;
  private $in_cargo_horas;

	function __construct()
	{
		parent::__construct();
	}

	public function setImage()
	{
		$imagem = $_FILES["imagem"];

		if($imagem != NULL)
		{
			$nomeFinal = time() . '.jpg';

			if (move_uploaded_file($imagem['tmp_name'], $nomeFinal))
			{
				$tamanhoImg = filesize($nomeFinal);
				$mysqlImg = addslashes(fread(fopen($nomeFinal, "r"), $tamanhoImg));

				$st_query = 'INSERT INTO Publicacao.Imagem (Imagem) VALUES ("' . $mysqlImg . '"")';

				try
				{
					//mysql_query("INSERT INTO PESSOA (PES_IMG) VALUES ('$mysqlImg')") or die("O sistema não foi capaz de executar a query");
					$this->o_db->query($st_query);
				}
				catch(PDOException $e)
				{
					echo 'Error: ' . $e->getMessage();
					throw new Exception("Error Processing Request", 1);

				}

				unlink($nomeFinal); //header("location:exibir.php");
			}
		}
		else
		{
			echo "Você não realizou o upload de forma satisfatória.";
		}

		return true;
	}

	public function getImage($id)
	{
		try
		{
			$st_query = 'SELECT * FROM PublicacaoImagem WHERE Codigo=' . $id;
			$data = $this->o_db->query($st_query);

			foreach($data as $row)
			{
				//echo $row['Imagem'];
				return $row['Imagem'];
			}
		}
		catch (PDOException $e)
		{
			echo 'ERROR: ' . $e->getMessage();
		}

		return false;
	}



  public function getId()
  {
	  return $this->in_id;
  }

  public function setDDD( $in_ddd )
  {
	  $this->in_ddd = $in_ddd;
	  return $this;
  }

  public function getDDD()
  {
	  return $this->in_ddd;
  }

  public function setTelefone( $in_telefone )
  {
	  $this->in_telefone = $in_telefone;
	  return $this;
  }

  public function getTelefone()
  {
	  return $this->in_telefone;
  }

  public function setContatoId( $in_contato_id )
  {
	  $this->in_contato_id = $in_contato_id;
	  return $this;
  }

  public function getContatoId()
  {
	  return $this->in_contato_id;
  }


  /**
  * Retorna um array contendo os telefones
  * de um determinado contato
  * @param integer $in_contato_id
  * @return Array
  */
  public function _list( $in_contato_id )
  {
	  $st_query = "SELECT * FROM tbl_telefone WHERE con_in_id = $in_contato_id";
	  $v_telefones = array();
	  try
	  {
		  $o_data = $this->o_db->query($st_query);
		  while($o_ret = $o_data->fetchObject())
		  {
			  $o_telefone = new TelefoneModel();
			  $o_telefone->setId($o_ret->tel_in_id);
			  $o_telefone->setDDD($o_ret->tel_in_ddd);
			  $o_telefone->setTelefone($o_ret->tel_in_telefone);
			  $o_telefone->setContatoId($o_ret->con_in_id);
			  array_push($v_telefones,$o_telefone);
		  }
	  }
	  catch(PDOException $e)
	  {}
	  return $v_telefones;
  }

  /**
  * Retorna os dados de um telefone referente
  * a um determinado Id
  * @param integer $in_id
  * @return TelefoneModel
  */
  public function loadById( $in_id )
  {
	  $v_contatos = array();
	  $st_query = "SELECT * FROM tbl_telefone WHERE tel_in_id = $in_id;";
	  try
	  {
		  $o_data = $this->o_db->query($st_query);
		  $o_ret = $o_data->fetchObject();
		  $this->setId($o_ret->tel_in_id);
		  $this->setDDD($o_ret->tel_in_ddd);
		  $this->setTelefone($o_ret->tel_in_telefone);
		  $this->setContatoId($o_ret->con_in_id);
		  return $this;
	  }
	  catch(PDOException $e)
	  {}
	  return false;
  }

  /**
  * Salva dados contidos na instancia da classe
  * na tabela de telefone. Se o ID for passado,
  * um UPDATE será executado, caso contrário, um
  * INSERT será executado
  * @throws PDOException
  * @return integer
  */
  public function save()
  {
	  if(is_null($this->in_id))
		  $st_query = "INSERT INTO tbl_telefone
					  (
						  con_in_id,
						  tel_in_ddd,
						  tel_in_telefone
					  )
					  VALUES
					  (
						  $this->in_contato_id,
						  '$this->in_ddd',
						  '$this->in_telefone'
					  );";
	  else
		  $st_query = "UPDATE
						  tbl_telefone
					  SET
						  tel_in_ddd = '$this->in_ddd',
						  tel_in_telefone = '$this->in_telefone'
					  WHERE
						  tel_in_id = $this->in_id";
	  try
	  {

		  if($this->o_db->exec($st_query) > 0)
			  if(is_null($this->in_id))
			  {
				 /*
				  * verificando se o driver usado é sqlite e pegando o ultimo id inserido
				  * por algum motivo, a função nativa do PDO::lastInsertId() não funciona com sqlite
				  */
				  if($this->o_db->getAttribute(PDO::ATTR_DRIVER_NAME) === 'sqlite')
				  {
					  $o_ret = $this->o_db->query('SELECT last_insert_rowid() AS tel_in_id')->fetchObject();
					  return $o_ret->tel_in_id;
				  }
				  else
					  return $this->o_db->lastInsertId();
			  }
			  else
				  return $this->in_id;
	  }
	  catch (PDOException $e)
	  {
		  throw $e;
	  }
	  return false;
  }

  /**
  * Deleta os dados persistidos na tabela de
  * telefone usando como referencia, o id da classe.
  */
  public function delete()
  {
	  if(!is_null($this->in_id))
	  {
		  $st_query = "DELETE FROM
						  tbl_telefone
					  WHERE tel_in_id = $this->in_id";
		  if($this->o_db->exec($st_query) > 0)
			  return true;
	  }
	  return false;
  }



	/** DEPRECIADO !
	* Cria tabela para armazernar os dados de telefone, caso
	* ela ainda não exista.
	* @throws PDOException
	*/
	private function createTablePublicacoes()
	{
		$st_query = 'CREATE SCHEMA IF NOT EXISTS "Publicacao"';

		//executando a query;
		try
		{
			$this->o_db->exec($st_query);
		}
		catch(PDOException $e)
		{
			throw $e;
		}

		$st_query = 'CREATE TABLE IF NOT EXISTS "Publicacao"."Imagem"
					(
						Codigo SERIAL NOT NULL,
						Nome VARCHAR(50),
						Descricao VARCHAR(200),
						Imagem OID NOT NULL,

						CONSTRAINT "PK_Codigo" PRIMARY KEY (Codigo)
					)';

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