/*
* Database Creation
*/

DROP DATABASE IF EXISTS 'CProSite';

CREATE DATABASE 'CProSite' CHARACTER SET UTF8;

ALTER DATABASE `CProSite` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE ''


CREATE TABLE 'Configuracao.Sistema'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	Nome VARCHAR(200) NOT NULL,
	Ativo BIT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

	PRIMARY KEY (Codigo)
);

CREATE TABLE 'Configuracao.Campanha'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	CodigoSistema INT NOT NULL,
	Nome VARCHAR(200) NOT NULL,
	Ativo BIT NOT NULL,
	DataInicio TIMESTAMP NOT NULL,
	DataTermino TIMESTAMP NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo)
);

CREATE TABLE 'Configuracao.SubCampanha'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	CodigoCampanha INT NOT NULL,
	Nome VARCHAR(200) NOT NULL,
	Ativo BIT NOT NULL,
	DataInicio TIMESTAMP NOT NULL,
	DataTermino TIMESTAMP NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoCampanha) REFERENCES Configuracao.Campanha(Codigo)
);

CREATE TABLE 'Configuracao.Procedure'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	Nome VARCHAR(200) NOT NULL,
	Ativo BIT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoCampanha) REFERENCES Configuracao.Campanha(Codigo)
);

CREATE TABLE 'Log.LogSistema'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	CodigoUsuario INT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

	PRIMARY KEY (Codigo)
);

CREATE TABLE 'Log.LogAuditoria'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	CodigoSistema INT NOT NULL,
	CodigoProcedure INT NOT NULL,
	CodigoUsuario INT,
	DataCriacao TIMESTAMP NOT NULL,
	IP VARCHAR(30),
	Parametros TEXT(2000),
	Resultado TINYINT,
	MensagemErro TEXT(2000),

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo),
	FOREIGN KEY (CodigoProcedure) REFERENCES Configuracao.Procedure(Codigo),
	FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo),


);


CREATE TABLE 'Cliente.Perfil'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	Nome VARCHAR(100),
	DataCriacao TIMESTAMP NOT NULL,

	CodigoUsuario INT NOT NULL,
	CodigoPerfil INT NOT NULL,

	FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo),
	FOREIGN KEY (CodigoPerfil) REFERENCES Cliente.Perfil(Codigo)
);


CREATE TABLE 'Cliente.ClientePerfil'
(
	CodigoUsuario INT NOT NULL,
	CodigoPerfil INT NOT NULL,

	PRIMARY KEY (CodigoUsuario, CodigoPerfil),
	FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo),
	FOREIGN KEY (CodigoPerfil) REFERENCES Cliente.Perfil(Codigo)
);


CREATE TABLE 'Cliente.Usuario'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
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

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
	FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo),
);

CREATE TABLE 'Cliente.HistoricoAcesso'
(
	CodigoUsuario INT,
	DataCriacao TIMESTAMP NOT NULL,
	IP VARCHAR(30),
	Login VARCHAR,

	FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo),
);

CREATE TABLE 'Cliente.Cliente'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
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

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo),
	FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo),
	FOREIGN KEY (CodigoTelefone) REFERENCES Cliente.Telefone(Codigo),
);


CREATE TABLE 'Cliente.TipoRedeSocial'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	Nome VARCHAR(50) NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

	PRIMARY KEY (Codigo),
);

CREATE TABLE 'Cliente.RedeSocial'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	CodigoCliente INT NOT NULL,
	CodigoRedeSocial

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
	FOREIGN KEY (CodigoRedeSocial) REFERENCES Cliente.TipoRedeSocial(Codigo)
);


CREATE TABLE 'Cliente.Telefone'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	Telefone VARCHAR(15) NOT NULL,
	TelefoneDDD VARCHAR(8) NOT NULL,
	CodigoWhastAppStatus SMALLINT(6) NOT NULL,

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoWhastAppStatus) REFERENCES Cliente.WhastAppStatus(Codigo)
);


CREATE TABLE 'Cliente.WhastAppStatus'
(
	Codigo SMALLINT(6) NOT NULL AUTO_INCREMENT,
	Descricao VARCHAR(100) NOT NULL,

	PRIMARY KEY (Codigo)
);

CREATE TABLE 'Cliente.TipoOptin'

	Codigo INT NOT NULL AUTO_INCREMENT,
	Descricao VARCHAR(50) NOT NULL,
	Ativo BIT NOT NULL,

	PRIMARY KEY (Codigo)
);

CREATE TABLE 'Cliente.ClienteOptin'
(
	CodigoCliente INT NOT NULL,
	CodigoTipoOptin INT NOT NULL,

	PRIMARY KEY (CodigoCliente, CodigoTipoOptin),
	FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
	FOREIGN KEY (CodigoTipoOptin) REFERENCES Cliente.TipoOptin(Codigo)
);

CREATE TABLE 'Cliente.Genero'
(
	Codigo TINYINT NOT NULL AUTO_INCREMENT,
	Descricao VARCHAR(30) NOT NULL,

	PRIMARY KEY (Codigo)
);


-- Cria o disparo de determinado e-mail sistêmico para determinado cliente
CREATE TABLE 'Email.DisparoEmail'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	CodigoCliente INT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL

	FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
);

-- Armazena os templates de e-mails sistêmicos associado a entidade Campanha
CREATE TABLE 'Email.TemplateEmail'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	CodigoCampanha INT NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,
	Descricao VARCHAR(200) NOT NULL,
	Titulo VARCHAR(200) NOT NULL,
	HTML TEXT(65000) NOT NULL,
	Ativo BIT NOT NULL,

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoCampanha) REFERENCES Configuracao.Campanha(Codigo)
);

-- Armazena os parâmetros dinâmicos dos e-mails sistêmicos
CREATE TABLE 'Email.ParametroEmail'
(
	CodigoTemplateEmail INT NOT NULL,
	NomeParametro VARCHAR(100) NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

);

-- Considerar planos,
CREATE TABLE 'Produto.Produto'
(

);

CREATE TABLE 'Produto.Estoque'
(

);


CREATE TABLE 'Transacao.Estoque'
(

);

CREATE TABLE 'Publicacao.Publicacao'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
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

	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoCampanha) REFERENCES Configuracao.Campanha(Codigo)
);

CREATE TABLE 'Publicacao.AutorPublicacao'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	CodigoCliente INT NOT NULL,
	CodigoPublicacao INT NOT NULL,


	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
	FOREIGN KEY (CodigoPublicacao) REFERENCES Publicacao.Publicacao(Codigo)
);

CREATE TABLE 'Publicacao.Imagem'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	Nome VARCHAR(50),
	Descricao VARCHAR(200),
	Imagem LONGBLOB NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,

	PRIMARY KEY (Codigo)
);

-- Inserção de Sistema padrão de gerenciamento
INSERT INTO Configuracao.Sistema(Nome, Ativo) VALUES ('Gerenciamento Banco de Dados', 1);

-- Inserção de tipos de redes sociais
INSERT INTO Cliente.TipoRedeSocial(Nome) VALUES ('Facebook'), ('Twitter'), ('Instagram'), ('LinkedIn');

-- Libera permissão para o Root e usrAppCPRO
GRANT ALL PRIVILEGES ON CProSite.* TO root@localhost IDENTIFIED BY 'osk5912';
GRANT SELECT, INSERT ON CProSite.* TO usrAppCPro@localhost IDENTIFIED BY 'Sj6eA76Hf2Y4f56xG6BW';
