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
	Parametros VARCHAR(2000),
	Resultado TINYINT,
	MensagemErro VARCHAR(2000),

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
	Login VARCHAR(150) NOT NULL,
	Senha VARCHAR(150) NOT NULL,
	DataCriacao TIMESTAMP NOT NULL,
	ChaveTrocaSenha VARCHAR(20),
	ChaveAtivacao VARCHAR(100),
	Bloqueio TINYINT NOT NULL ,
	Ativo BIT NOT NULL,

	PRIMARY KEY (Codigo),
	FOREIGN KEY () REFERENCES TABLE(name),

);


CREATE TABLE 'Cliente.Cliente'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	CodigoUsuario INT NOT NULL,
	CodigoSistema INT NOT NULL,
	CodigoTelefone INT,
	Nome VARCHAR(100),
	Sobrenome
	Documento VARCHAR(50),


	Nascimento DATE,

	CodigoGenero TINYINT,

	Cidade VARCHAR(200),
	Estado VARCHAR(80),
	EnderecoLogradouro VARCHAR(),
	EnderecoCodigoPostal VARCHAR(),
	EnderecoNumero VARCHAR(),
	EnderecoComplemento VARCHAR(),
	EnderecoBairro VARCHAR(),

	DataCriacao TIMESTAMP NOT NULL,
	DataAlteracao TIMESTAMP NOT NULL,


	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoUsuario) REFERENCES Cliente.Usuario(Codigo),
	FOREIGN KEY (CodigoSistema) REFERENCES Configuracao.Sistema(Codigo),
	FOREIGN KEY (CodigoTelefone) REFERENCES Cliente.Telefone(Codigo),

);


CREATE TABLE 'Cliente.Telefone'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	Telefone VARCHAR(15) NOT NULL,
	TelefoneDDD VARCHAR(8) NOT NULL
);



CREATE TABLE 'Cliente.ClienteOptin'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	CodigoCliente INT NOT NULL,
	CodigoTipoOptin INT NOT NULL,
	PRIMARY KEY (Codigo),
	FOREIGN KEY (CodigoCliente) REFERENCES Cliente.Cliente(Codigo),
	FOREIGN KEY (CodigoTipoOptin) REFERENCES Cliente.TipoOptin(Codigo)
);

CREATE TABLE 'Cliente.TipoOptin'
(
	Codigo INT NOT NULL AUTO_INCREMENT,
	Descricao VARCHAR(50) NOT NULL,
	Ativo BIT NOT NULL,
	PRIMARY KEY (Codigo),
);

CREATE TABLE 'Cliente.Genero'
(
	Codigo TINYINT NOT NULL AUTO_INCREMENT,
	Descricao VARCHAR(30) NOT NULL,

	PRIMARY KEY (Codigo)
);



INSERT INTO Configuracao.Sistema(Nome, Ativo) VALUES ('Gerenciamento Banco de Dados', 1);