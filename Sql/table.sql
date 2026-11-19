CREATE TABLE CATEGORIA (
    id_categoria INT primary key AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao text
);

CREATE TABLE USUARIO (
    id_usuario UUID primary key NOT NULL DEFAULT (UUID()),
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL
);

CREATE TABLE MUSICA (
    id_musica INT primary key AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    compositor VARCHAR(150),
    ano_composicao INT,
    descricao VARCHAR(300)
);

CREATE TABLE ITEM_ACERVO (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_categoria INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    descricao text,
    origem VARCHAR(200),
    data_aquisicao DATE,
    estado_conservacao VARCHAR(50), /* Possivel mudança para Enum */
    status ENUM("Disponível","Indisponível") NOT NULL,
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_alteracao DATETIME(2) NOT NULL DEFAULT CURRENT_TIMESTAMP(2)
                   ON UPDATE CURRENT_TIMESTAMP(2),
    id_usuario_cadastro UUID NOT NULL,
     FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria),
     FOREIGN KEY (id_usuario_cadastro) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE DOCUMENTO (
    id_item INT PRIMARY KEY,
    tipo_documento VARCHAR(50) NOT NULL,
    autor VARCHAR(150),
    data_documento DATE,
    FOREIGN KEY (id_item) REFERENCES ITEM_ACERVO(id_item)
);

CREATE TABLE INSTRUMENTO (
    id_item INT PRIMARY KEY,
    tipo_instrumento VARCHAR(100) NOT NULL,
    fabricante VARCHAR(150),
    ano_fabricacao SMALLINT,
    antigo_dono VARCHAR(150),
    FOREIGN KEY (id_item) REFERENCES ITEM_ACERVO(id_item)
);

CREATE TABLE PARTITURA (
    id_item INT PRIMARY KEY,
    id_musica INT NOT NULL,
    autor VARCHAR(150),
    ano_criacao INT,
    arquivo_url VARCHAR(500),
    FOREIGN KEY (id_item) REFERENCES ITEM_ACERVO(id_item),
    FOREIGN KEY (id_musica) REFERENCES MUSICA(id_musica)
);

CREATE TABLE MIDIA (
    id_midia INT PRIMARY KEY AUTO_INCREMENT,
    id_item INT NOT NULL,
    tipo_midia VARCHAR(30) NOT NULL,
    arquivo_url VARCHAR(500) NOT NULL,
    descricao text,
    FOREIGN KEY (id_item) REFERENCES ITEM_ACERVO(id_item)
);

CREATE TABLE COLECAO (
    id_colecao INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    descricao text
);


CREATE TABLE COLECAO_ITEM (
    id_colecao INT,
    id_item INT,
    FOREIGN KEY (id_colecao) REFERENCES COLECAO(id_colecao),
    FOREIGN KEY (id_item) REFERENCES ITEM_ACERVO(id_item),
    primary key(id_colecao,id_item)
);