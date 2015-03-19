
------------------------------------------ Create and Drop Database ------------------------------------------

DROP DATABASE IF EXISTS "CProSite";

CREATE DATABASE "CProSite"
	WITH ENCODING = 'UTF-8'
	OWNER = "usrAppCPro"
	LC_COLLATE = 'Portuguese_Brazil.1252'
	LC_CTYPE = 'Portuguese_Brazil.1252'
	CONNECTION LIMIT = -1;
--------------------------------------------------------------------------------------------------------------


----------------------------------------------- Database Set -------------------------------------------------
\c CProSite
--------------------------------------------------------------------------------------------------------------


------------------------------------------ Create and Drop Schemas -------------------------------------------

DROP SCHEMA IF EXISTS Configuracao CASCADE;
DROP SCHEMA IF EXISTS RedeSocial CASCADE;
DROP SCHEMA IF EXISTS Publicacao CASCADE;
DROP SCHEMA IF EXISTS Cliente CASCADE;
DROP SCHEMA IF EXISTS Email CASCADE;
DROP SCHEMA IF EXISTS Log CASCADE;

CREATE SCHEMA IF NOT EXISTS Configuracao;
CREATE SCHEMA IF NOT EXISTS RedeSocial;
CREATE SCHEMA IF NOT EXISTS Publicacao;
CREATE SCHEMA IF NOT EXISTS Cliente;
CREATE SCHEMA IF NOT EXISTS Email;
CREATE SCHEMA IF NOT EXISTS Log;
--------------------------------------------------------------------------------------------------------------


---------------------------------------- Create Database Types (ENUM) ----------------------------------------

CREATE TYPE GENERO AS ENUM ('Indefinido', 'Masculino', 'Feminino');
CREATE TYPE TELEFONE AS ENUM ('Indefinido', 'Residencial', 'Comercial', 'FAX', 'Celular', 'Outro');
--------------------------------------------------------------------------------------------------------------


-------------------------------------------- Create Databases UML --------------------------------------------

CREATE TABLE IF NOT EXISTS Configuracao.Sistema
(
	Codigo SERIAL NOT NULL,
	Nome VARCHAR(200) NOT NULL,
	Ativo BOOLEAN NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo)
);

CREATE TABLE IF NOT EXISTS Configuracao.Campanha
(
	Codigo SERIAL NOT NULL,
	CodigoSistema INT NOT NULL,
	Nome VARCHAR(200) NOT NULL,
	Ativo BOOLEAN NOT NULL,
	DataInicio TIMESTAMP NOT NULL DEFAULT current_timestamp,
	DataTermino TIMESTAMP NOT NULL DEFAULT current_timestamp,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo)
);

CREATE TABLE IF NOT EXISTS Configuracao.SubCampanha
(
	Codigo SERIAL NOT NULL,
	CodigoCampanha INT NOT NULL,
	Nome VARCHAR(200) NOT NULL,
	Ativo BOOLEAN NOT NULL,
	DataInicio TIMESTAMP NOT NULL DEFAULT current_timestamp,
	DataTermino TIMESTAMP NOT NULL DEFAULT current_timestamp,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoCampanha) REFERENCES Configuracao.Campanha(Codigo)
);

CREATE TABLE IF NOT EXISTS Configuracao.Procedure
(
	Codigo SERIAL NOT NULL,
	CodigoSistema INT NOT NULL,
	Nome VARCHAR(200) NOT NULL,
	Ativo BOOLEAN NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo)
);

CREATE TABLE IF NOT EXISTS Cliente.Usuario
(
	Codigo SERIAL NOT NULL,
	CodigoCliente INT NOT NULL,
	CodigoSistema INT NOT NULL,
	Login VARCHAR(255) NOT NULL,
	Senha VARCHAR(255) NOT NULL,
	ChaveTrocaSenha VARCHAR(255),
	ChaveAtivacao VARCHAR(100),
	TentativasInvalidas SMALLINT,
	Bloqueio BOOLEAN NOT NULL,
	Ativo BOOLEAN NOT NULL,
	Debug BOOLEAN NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,
	DataAlteracao TIMESTAMP,
	DataUltimoAcesso TIMESTAMP,
	DataTrocaSenha TIMESTAMP,
	DataLiberacaoBloqueio TIMESTAMP,

	PRIMARY KEY (Codigo),
	--FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
	FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo)
);

CREATE TABLE IF NOT EXISTS Cliente.HistoricoAcesso
(
	CodigoUsuario INT,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,
	IP VARCHAR(30),
	Login VARCHAR,

	FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo)
);

CREATE TABLE IF NOT EXISTS Cliente.Telefone
(
	Codigo SERIAL NOT NULL,
	Telefone VARCHAR(15) NOT NULL,
	TelefoneDDD VARCHAR(8) NOT NULL,
	TipoTelefone TELEFONE NOT NULL, 
	OptinWhastApp BOOLEAN NOT NULL,
	OptinSMS BOOLEAN NOT NULL,
	Ativo BOOLEAN NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo)
);

CREATE TABLE IF NOT EXISTS Cliente.Cliente
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
	Genero GENERO,

	Cidade VARCHAR(255),
	Estado VARCHAR(100),
	EnderecoCodigoPostal VARCHAR(25),
	EnderecoLogradouro VARCHAR(255),
	EnderecoNumero VARCHAR(10),
	EnderecoComplemento VARCHAR(200),
	EnderecoBairro VARCHAR(255),

	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,
	DataAlteracao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo),
	FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo),
	FOREIGN KEY (CodigoTelefone) REFERENCES Cliente.Telefone(Codigo)
);


CREATE TABLE IF NOT EXISTS Configuracao.Modulo
(
	Codigo SERIAL NOT NULL,
	CodigoSistema INT NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	Descricao VARCHAR(200),
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo)
);

CREATE TABLE IF NOT EXISTS Configuracao.Perfil
(
	Codigo SERIAL NOT NULL,
	CodigoSistema INT NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	Descricao VARCHAR(200),
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo)
);

CREATE TABLE IF NOT EXISTS Configuracao.ModuloPerfil
(
	CodigoSistema INT NOT NULL,
	CodigoPerfil INT NOT NULL,
	CodigoModulo INT NOT NULL,
	OrdemExibicao SMALLINT,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (CodigoSistema, CodigoPerfil, CodigoModulo),
	FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo),
	FOREIGN KEY (CodigoPerfil) REFERENCES Configuracao.Perfil(Codigo),
	FOREIGN KEY (CodigoModulo) REFERENCES Configuracao.Modulo(Codigo)
);

CREATE TABLE IF NOT EXISTS Configuracao.ClientePerfil
(
	CodigoUsuario INT NOT NULL,
	CodigoPerfil INT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (CodigoUsuario, CodigoPerfil),
	FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo),
	FOREIGN KEY (CodigoPerfil) REFERENCES Configuracao.Perfil(Codigo)
);

CREATE TABLE IF NOT EXISTS RedeSocial.Facebook
(
	Codigo SERIAL NOT NULL,
	CodigoCliente INT NOT NULL, 
	TokenAcesso VARCHAR(250) NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo),
	UNIQUE (Codigo, CodigoCliente),
	FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo)
);

CREATE TABLE IF NOT EXISTS RedeSocial.LinkedIn
(
	Codigo SERIAL NOT NULL,
	CodigoCliente INT NOT NULL, 
	TokenAcesso VARCHAR(250) NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo),
	UNIQUE (Codigo, CodigoCliente),
	FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo)
);

CREATE TABLE IF NOT EXISTS RedeSocial.Twitter
(
	Codigo SERIAL NOT NULL,
	CodigoCliente INT NOT NULL, 
	TokenAcesso VARCHAR(250) NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo),
	UNIQUE (Codigo, CodigoCliente),
	FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo)
);

CREATE TABLE IF NOT EXISTS RedeSocial.Instagram
(
	Codigo SERIAL NOT NULL,
	CodigoCliente INT NOT NULL, 
	TokenAcesso VARCHAR(250) NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo),
	UNIQUE (Codigo, CodigoCliente),
	FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo)
);

CREATE TABLE IF NOT EXISTS Cliente.RedeSocial
(
	Codigo SERIAL NOT NULL,
	CodigoCliente INT NOT NULL,
	CodigoFacebook INT,
	CodigoInstagram INT,
	CodigoLinkedin INT,
	CodigoTwitter INT,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo, CodigoCliente),
	FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
	FOREIGN KEY (CodigoFacebook) REFERENCES RedeSocial.Facebook(Codigo),
	FOREIGN KEY (CodigoInstagram) REFERENCES RedeSocial.Instagram(Codigo),
	FOREIGN KEY (CodigoLinkedin) REFERENCES RedeSocial.LinkedIn(Codigo),
	FOREIGN KEY (CodigoTwitter) REFERENCES RedeSocial.Twitter(Codigo)
);


CREATE TABLE IF NOT EXISTS Cliente.TipoOptin
(
	Codigo SMALLSERIAL NOT NULL,
	Descricao VARCHAR(50) NOT NULL,
	Ativo BOOLEAN NOT NULL,

	PRIMARY KEY (Codigo)
);

CREATE TABLE IF NOT EXISTS Cliente.ClienteOptin
(
	CodigoCliente INT NOT NULL,
	CodigoTipoOptin INT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (CodigoCliente, CodigoTipoOptin),
	FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
	FOREIGN KEY (CodigoTipoOptin) REFERENCES Cliente.TipoOptin(Codigo)
);

-- Cria o disparo de determinado e-mail sistêmico para determinado cliente
CREATE TABLE IF NOT EXISTS Email.DisparoEmail
(
	Codigo SERIAL NOT NULL,
	CodigoCliente INT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo)
);

-- Armazena os templates de e-mails sistêmicos associado a entidade Campanha
CREATE TABLE IF NOT EXISTS Email.TemplateEmail
(
	Codigo SERIAL NOT NULL,
	CodigoCampanha INT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,
	Descricao VARCHAR(200) NOT NULL,
	Titulo VARCHAR(200) NOT NULL,
	HTML TEXT NOT NULL,
	Ativo BOOLEAN NOT NULL,

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoCampanha) REFERENCES Configuracao.Campanha(Codigo)
);

-- Armazena os parâmetros dinâmicos dos e-mails sistêmicos
CREATE TABLE IF NOT EXISTS Email.ParametroEmail
(
	CodigoTemplateEmail INT NOT NULL,
	NomeParametro VARCHAR(100) NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp

);

-- Considerar planos,
-- CREATE TABLE IF NOT EXISTS "Produto.Produto"
-- (

-- );

-- CREATE TABLE IF NOT EXISTS "Produto.Estoque"
-- (

-- );


-- CREATE TABLE IF NOT EXISTS "Transacao.Estoque"
-- (

-- );

CREATE TABLE IF NOT EXISTS Publicacao.Publicacao
(
	Codigo SERIAL NOT NULL,
	CodigoCampanha INT NOT NULL,
	Nome VARCHAR(50),
	Descricao VARCHAR(200),
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,
	DataAlteracao TIMESTAMP NOT NULL DEFAULT current_timestamp,
	CodigoImagem INT,
	LinkImagem VARCHAR(200),
	TituloArtigo VARCHAR(200),
	Artigo TEXT,
	Resumo TEXT,
	Publicado BOOLEAN NOT NULL,
	Ativo BOOLEAN NOT NULL,

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoCampanha) REFERENCES Configuracao.Campanha(Codigo)
);

CREATE TABLE IF NOT EXISTS Publicacao.AutorPublicacao
(
	Codigo SERIAL NOT NULL,
	CodigoCliente INT NOT NULL,
	CodigoPublicacao INT NOT NULL,


	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
	FOREIGN KEY (CodigoPublicacao) REFERENCES Publicacao.Publicacao(Codigo)
);

CREATE TABLE IF NOT EXISTS Publicacao.Imagem
(
	Codigo SERIAL NOT NULL,
	Nome VARCHAR(50),
	Descricao VARCHAR(200),
	Imagem OID NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo)
);


CREATE TABLE IF NOT EXISTS Log.LogSistema
(
	Codigo SERIAL NOT NULL,
	CodigoUsuario INT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,

	PRIMARY KEY (Codigo)
);

CREATE TABLE IF NOT EXISTS Log.LogAuditoria
(
	Codigo SERIAL NOT NULL,
	CodigoSistema INT NOT NULL,
	CodigoProcedure INT NOT NULL,
	CodigoUsuario INT,
	DataCriacao TIMESTAMP NOT NULL DEFAULT current_timestamp,
	IP VARCHAR(30),
	Parametros TEXT,
	Resultado SMALLINT,
	MensagemErro TEXT,

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo),
	FOREIGN KEY (CodigoProcedure) REFERENCES Configuracao.Procedure(Codigo),
	FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo)
);
--------------------------------------------------------------------------------------------------------------


-------------------------------------------- Insert Principal Data -------------------------------------------

-- Inserção de Sistema padrão de gerenciamento
INSERT INTO Configuracao.Sistema (Nome, Ativo) VALUES ('Gerenciamento Banco de Dados', TRUE);
--------------------------------------------------------------------------------------------------------------


-------------------------------- Grant Access To Users on Schemas and Tables ---------------------------------

GRANT ALL PRIVILEGES ON "CProSite" TO postgres;
GRANT SELECT, INSERT ON "CProSite" TO usrAppCPro;
--------------------------------------------------------------------------------------------------------------