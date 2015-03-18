/*
* Database Creation
*/

DROP DATABASE IF EXISTS 'CProSite';


CREATE DATABASE "CProSite" 
	WITH ENCODING = 'windows_1252' 
	OWNER = usrAppCPro 
	LC_COLLATE = 'Portuguese_Brazil.1252'
	LC_CTYPE = 'Portuguese_Brazil.1252' 
	CONNECTION LIMIT = -1;

CREATE SCHEMA IF NOT EXISTS 'Publicacao';


CREATE TABLE IF NOT EXISTS ''


CREATE TABLE IF NOT EXISTS 'Configuracao.Sistema'
(
	Codigo SERIAL NOT NULL,
	Nome VARCHAR(200) NOT NULL,
	Ativo BIT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo)
);

CREATE TABLE IF NOT EXISTS 'Configuracao.Campanha'
(
	Codigo SERIAL NOT NULL,
	CodigoSistema INT NOT NULL,
	Nome VARCHAR(200) NOT NULL,
	Ativo BIT NOT NULL,
	DataInicio TIMESTAMP NOT NULL,
	DataTermino TIMESTAMP NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo),
	CONSTRAINT 'FK_CodigoSistema' FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo)
);

CREATE TABLE IF NOT EXISTS 'Configuracao.SubCampanha'
(
	Codigo SERIAL NOT NULL,
	CodigoCampanha INT NOT NULL,
	Nome VARCHAR(200) NOT NULL,
	Ativo BIT NOT NULL,
	DataInicio TIMESTAMP NOT NULL,
	DataTermino TIMESTAMP NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo),
	CONSTRAINT 'FK_CodigoCampanha' FOREIGN KEY (CodigoCampanha) REFERENCES Configuracao.Campanha(Codigo)
);

CREATE TABLE IF NOT EXISTS 'Configuracao.Procedure'
(
	Codigo SERIAL NOT NULL,
	Nome VARCHAR(200) NOT NULL,
	Ativo BIT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo),
	CONSTRAINT 'FK_' FOREIGN KEY (CodigoCampanha) REFERENCES Configuracao.Campanha(Codigo)
);

CREATE TABLE IF NOT EXISTS 'Log.LogSistema'
(
	Codigo SERIAL NOT NULL,
	CodigoUsuario INT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo)
);

CREATE TABLE IF NOT EXISTS 'Log.LogAuditoria'
(
	Codigo SERIAL NOT NULL,
	CodigoSistema INT NOT NULL,
	CodigoProcedure INT NOT NULL,
	CodigoUsuario INT,
	DataCriacao TIMESTAMP NOT NULL,
	IP VARCHAR(30),
	Parametros TEXT(2000),
	Resultado TINYINT,
	MensagemErro TEXT(2000),

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo),
	CONSTRAINT 'FK_CodigoSistema' FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo),
	CONSTRAINT 'FK_CodigoProcedure' FOREIGN KEY (CodigoProcedure) REFERENCES Configuracao.Procedure(Codigo),
	CONSTRAINT 'FK_CodigoUsuario' FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo),


);


CREATE TABLE IF NOT EXISTS 'Cliente.Perfil'
(
	Codigo SERIAL NOT NULL,
	Nome VARCHAR(100),
	DataCriacao TIMESTAMP NOT NULL,

	CodigoUsuario INT NOT NULL,
	CodigoPerfil INT NOT NULL,

	CONSTRAINT 'FK_CodigoUsuario' FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo),
	CONSTRAINT 'FK_CodigoPerfil' FOREIGN KEY (CodigoPerfil) REFERENCES Cliente.Perfil(Codigo)
);


CREATE TABLE IF NOT EXISTS 'Cliente.ClientePerfil'
(
	CodigoUsuario INT NOT NULL,
	CodigoPerfil INT NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (CodigoUsuario, CodigoPerfil),
	CONSTRAINT 'FK_CodigoUsuario' FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo),
	CONSTRAINT 'FK_CodigoPerfil' FOREIGN KEY (CodigoPerfil) REFERENCES Cliente.Perfil(Codigo)
);


CREATE TABLE IF NOT EXISTS 'Cliente.Usuario'
(
	Codigo SERIAL NOT NULL,
	CodigoCliente INT NOT NULL,
	CodigoSistema INT NOT NULL,
	Login VARCHAR(255) NOT NULL,
	Senha VARCHAR(255) NOT NULL,
	ChaveTrocaSenha VARCHAR(255),
	ChaveAtivacao VARCHAR(100),
	TentativasInvalidas TINYINT SIGNED,
	Bloqueio BIT NOT NULL,
	Ativo BIT NOT NULL,
	Debug BIT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,
	DataAlteracao TIMESTAMP,
	DataUltimoAcesso TIMESTAMP,
	DataTrocaSenha TIMESTAMP,
	DataLiberacaoBloqueio TIMESTAMP,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo),
	CONSTRAINT 'FK_CodigoCliente' FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
	CONSTRAINT 'FK_CodigoSistema' FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo),
);

CREATE TABLE IF NOT EXISTS 'Cliente.HistoricoAcesso'
(
	CodigoUsuario INT,
	DataCriacao TIMESTAMP NOT NULL,
	IP VARCHAR(30),
	Login VARCHAR,

	CONSTRAINT 'FK_CodigoUsuario' FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo),
);

CREATE TABLE IF NOT EXISTS 'Cliente.Cliente'
(
	Codigo SERIAL NOT NULL,
	CodigoUsuario INT NOT NULL,
	CodigoSistema INT NOT NULL,
	CodigoTelefone INT,
	Nome VARCHAR(100),
	Sobrenome VARCHAR(100),
	Apelido VARCHAR(100),
	Documento VARCHAR(50),
	Email VARCHAR(200),
	Nascimento DATE,
	CodigoGenero TINYINT,

	Cidade VARCHAR(255),
	Estado VARCHAR(100),
	EnderecoCodigoPostal VARCHAR(25),
	EnderecoLogradouro VARCHAR(255),
	EnderecoNumero VARCHAR(10),
	EnderecoComplemento VARCHAR(200),
	EnderecoBairro VARCHAR(255),

	DataCriacao TIMESTAMP NOT NULL,
	DataAlteracao TIMESTAMP NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo),
	CONSTRAINT 'FK_CodigoUsuario' FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo),
	CONSTRAINT 'FK_CodigoSistema' FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo),
	CONSTRAINT 'FK_CodigoTelefone' FOREIGN KEY (CodigoTelefone) REFERENCES Cliente.Telefone(Codigo),
);


CREATE TABLE IF NOT EXISTS 'Cliente.TipoRedeSocial'
(
	Codigo SERIAL NOT NULL,
	Nome VARCHAR(50) NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo),
);

CREATE TABLE IF NOT EXISTS 'Cliente.RedeSocial'
(
	Codigo SERIAL NOT NULL,
	CodigoCliente INT NOT NULL,
	CodigoRedeSocial

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo),
	CONSTRAINT 'FK_CodigoCliente' FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
	CONSTRAINT 'FK_CodigoRedeSocial' FOREIGN KEY (CodigoRedeSocial) REFERENCES Cliente.TipoRedeSocial(Codigo)
);


CREATE TABLE IF NOT EXISTS 'Cliente.Telefone'
(
	Codigo SERIAL NOT NULL,
	Telefone VARCHAR(15) NOT NULL,
	TelefoneDDD VARCHAR(8) NOT NULL,
	CodigoWhastAppStatus SMALLINT(6) NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo),
	CONSTRAINT 'FK_CodigoWhastAppStatus' FOREIGN KEY (CodigoWhastAppStatus) REFERENCES Cliente.WhastAppStatus(Codigo)
);


CREATE TABLE IF NOT EXISTS 'Cliente.WhastAppStatus'
(
	Codigo SERIAL NOT NULL,
	Descricao VARCHAR(100) NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo)
);

CREATE TABLE IF NOT EXISTS 'Cliente.TipoOptin'

	Codigo SMALLSERIAL NOT NULL,
	Descricao VARCHAR(50) NOT NULL,
	Ativo BIT NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo)
);

CREATE TABLE IF NOT EXISTS 'Cliente.ClienteOptin'
(
	CodigoCliente INT NOT NULL,
	CodigoTipoOptin INT NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (CodigoCliente, CodigoTipoOptin),
	CONSTRAINT 'FK_CodigoCliente' FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
	CONSTRAINT 'FK_CodigoTipoOptin' FOREIGN KEY (CodigoTipoOptin) REFERENCES Cliente.TipoOptin(Codigo)
);

CREATE TABLE IF NOT EXISTS 'Cliente.Genero'
(
	Codigo SMALLSERIAL NOT NULL,
	Descricao VARCHAR(30) NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo)
);


-- Cria o disparo de determinado e-mail sistêmico para determinado cliente
CREATE TABLE IF NOT EXISTS 'Email.DisparoEmail'
(
	Codigo SERIAL NOT NULL,
	CodigoCliente INT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL

	CONSTRAINT 'FK_CodigoCliente' FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
);

-- Armazena os templates de e-mails sistêmicos associado a entidade Campanha
CREATE TABLE IF NOT EXISTS 'Email.TemplateEmail'
(
	Codigo SERIAL NOT NULL,
	CodigoCampanha INT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,
	Descricao VARCHAR(200) NOT NULL,
	Titulo VARCHAR(200) NOT NULL,
	HTML TEXT(65000) NOT NULL,
	Ativo BIT NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo),
	CONSTRAINT 'FK_CodigoCampanha' FOREIGN KEY (CodigoCampanha) REFERENCES Configuracao.Campanha(Codigo)
);

-- Armazena os parâmetros dinâmicos dos e-mails sistêmicos
CREATE TABLE IF NOT EXISTS 'Email.ParametroEmail'
(
	CodigoTemplateEmail INT NOT NULL,
	NomeParametro VARCHAR(100) NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

);

-- Considerar planos,
CREATE TABLE IF NOT EXISTS 'Produto.Produto'
(

);

CREATE TABLE IF NOT EXISTS 'Produto.Estoque'
(

);


CREATE TABLE IF NOT EXISTS 'Transacao.Estoque'
(

);

CREATE TABLE IF NOT EXISTS 'Publicacao.Publicacao'
(
	Codigo SERIAL NOT NULL,
	CodigoCampanha INT NOT NULL,
	Nome VARCHAR(50),
	Descricao VARCHAR(200),
	DataCriacao TIMESTAMP NOT NULL,
	DataAlteracao TIMESTAMP,
	CodigoImagem INT,
	LinkImagem VARCHAR(200),
	TituloArtigo VARCHAR(200),
	Artigo TEXT(65000),
	Resumo TEXT(30000),
	Publicado BIT NOT NULL,
	Ativo BIT NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo),
	CONSTRAINT 'FK_CodigoCampanha' FOREIGN KEY (CodigoCampanha) REFERENCES Configuracao.Campanha(Codigo)
);

CREATE TABLE IF NOT EXISTS 'Publicacao.AutorPublicacao'
(
	Codigo SERIAL NOT NULL,
	CodigoCliente INT NOT NULL,
	CodigoPublicacao INT NOT NULL,


	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo),
	CONSTRAINT 'FK_CodigoCliente' FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
	CONSTRAINT 'FK_CodigoPublicacao' FOREIGN KEY (CodigoPublicacao) REFERENCES Publicacao.Publicacao(Codigo)
);

CREATE TABLE IF NOT EXISTS 'Publicacao.Imagem'
(
	Codigo SERIAL NOT NULL,
	Nome VARCHAR(50),
	Descricao VARCHAR(200),
	Imagem LONGBLOB NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

	CONSTRAINT 'PK_Codigo' PRIMARY KEY (Codigo)
);

-- Inserção de Sistema padrão de gerenciamento
INSERT INTO Configuracao.Sistema(Nome, Ativo) VALUES ('Gerenciamento Banco de Dados', 1);

-- Inserção de tipos de redes sociais
INSERT INTO Cliente.TipoRedeSocial(Nome) VALUES ('Facebook'), ('Twitter'), ('Instagram'), ('LinkedIn');

-- Libera permissão para o Root e usrAppCPRO
GRANT ALL PRIVILEGES ON CProSite.* TO root@localhost IDENTIFIED BY 'osk5912';
GRANT SELECT, INSERT ON CProSite.* TO usrAppCPro@localhost IDENTIFIED BY 'Sj6eA76Hf2Y4f56xG6BW';
