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

INSERT INTO CATEGORIA (nome, descricao) VALUES
('Documentos', 'Documentos históricos, registros e arquivos antigos.'),
('Instrumentos Musicais', 'Instrumentos musicais antigos e contemporâneos.'),
('Partituras', 'Partituras de músicas e composições históricas.'),
('Fotografias', 'Fotografias de apresentações, artistas e eventos musicais.'),
('Objetos Históricos', 'Objetos relacionados à história da música.');


INSERT INTO USUARIO (nome, email, senha) VALUES
('João Silva', 'joao@email.com', 'hash_senha_01'),
('Maria Oliveira', 'maria@email.com', 'hash_senha_02'),
('Pedro Santos', 'pedro@email.com', 'hash_senha_03'),
('Ana Costa', 'ana@email.com', 'hash_senha_04');


INSERT INTO MUSICA (titulo, compositor, ano_composicao, descricao) VALUES
('Asa Branca', 'Luiz Gonzaga e Humberto Teixeira', 1947, 'Clássico da música popular brasileira.'),
('Carinhoso', 'Pixinguinha', 1917, 'Uma das mais conhecidas composições do choro brasileiro.'),
('Aquarela do Brasil', 'Ary Barroso', 1939, 'Canção representativa da música brasileira.'),
('Garota de Ipanema', 'Tom Jobim e Vinicius de Moraes', 1962, 'Clássico da Bossa Nova.'),
('O Trenzinho do Caipira', 'Heitor Villa-Lobos', 1930, 'Composição orquestral inspirada no movimento de um trem.');


INSERT INTO ITEM_ACERVO
(id_categoria, titulo, descricao, origem, data_aquisicao,
 estado_conservacao, status, id_usuario_cadastro)
VALUES
(1, 'Carta histórica de Villa-Lobos',
 'Correspondência relacionada à trajetória do compositor.',
 'Arquivo histórico brasileiro', '2020-05-10',
 'Bom', 'Disponível',
 (SELECT id_usuario FROM USUARIO WHERE email = 'joao@email.com')),

(2, 'Violão antigo',
 'Instrumento utilizado em apresentações musicais.',
 'Doação particular', '2019-08-15',
 'Regular', 'Disponível',
 (SELECT id_usuario FROM USUARIO WHERE email = 'maria@email.com')),

(3, 'Partitura de Asa Branca',
 'Registro musical da composição Asa Branca.',
 'Arquivo musical', '2021-03-20',
 'Excelente', 'Disponível',
 (SELECT id_usuario FROM USUARIO WHERE email = 'pedro@email.com')),

(4, 'Fotografia de apresentação musical',
 'Fotografia histórica de uma apresentação ao vivo.',
 'Acervo fotográfico', '2018-11-12',
 'Bom', 'Disponível',
 (SELECT id_usuario FROM USUARIO WHERE email = 'ana@email.com')),

(5, 'Disco de vinil histórico',
 'Disco de vinil pertencente a uma coleção musical antiga.',
 'Coleção particular', '2022-02-18',
 'Regular', 'Indisponível',
 (SELECT id_usuario FROM USUARIO WHERE email = 'joao@email.com'));


INSERT INTO DOCUMENTO (id_item, tipo_documento, autor, data_documento)
VALUES
(1, 'Carta', 'Heitor Villa-Lobos', '1940-06-15');


INSERT INTO INSTRUMENTO
(id_item, tipo_instrumento, fabricante, ano_fabricacao, antigo_dono)
VALUES
(2, 'Violão clássico', 'Giannini', 1965, 'Antônio Ferreira');


INSERT INTO PARTITURA
(id_item, id_musica, autor, ano_criacao, arquivo_url)
VALUES
(3, 1, 'Luiz Gonzaga e Humberto Teixeira', 1947,
 'https://exemplo.com/partituras/asa-branca.pdf');


INSERT INTO MIDIA (id_item, tipo_midia, arquivo_url, descricao) VALUES
(1, 'Imagem', 'https://exemplo.com/imagens/carta-villa-lobos.jpg', 'Fotografia da carta histórica.'),
(2, 'Imagem', 'https://exemplo.com/imagens/violao-antigo.jpg', 'Fotografia do violão.'),
(3, 'PDF', 'https://exemplo.com/partituras/asa-branca.pdf', 'Arquivo digital da partitura.'),
(4, 'Imagem', 'https://exemplo.com/imagens/apresentacao.jpg', 'Fotografia da apresentação musical.');


INSERT INTO COLECAO (titulo, descricao) VALUES
('Memória da Música Brasileira', 'Coleção de registros históricos da música brasileira.'),
('Instrumentos Antigos', 'Coleção de instrumentos musicais de diferentes épocas.'),
('Compositores Brasileiros', 'Coleção dedicada a compositores brasileiros.'),
('Acervo Fotográfico', 'Coleção de fotografias de apresentações e eventos musicais.');


INSERT INTO COLECAO_ITEM (id_colecao, id_item) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

