DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS categoria_simples;
DROP TABLE IF EXISTS super_categoria;
DROP TABLE IF EXISTS tem_outra;
DROP TABLE IF EXISTS produto;
DROP TABLE IF EXISTS tem_categoria;
DROP TABLE IF EXISTS IVM;
DROP TABLE IF EXISTS ponto_de_retalho;
DROP TABLE IF EXISTS instalada_em;
DROP TABLE IF EXISTS prateleira;
DROP TABLE IF EXISTS planograma;
DROP TABLE IF EXISTS retalhista;
DROP TABLE IF EXISTS responsavel_por;
DROP TABLE IF EXISTS evento_reposicao;

CREATE TABLE categoria 
    (nome VARCHAR(50) NOT NULL CHECK((nome IN categoria_simples AND nome NOT IN super_categoria) OR 
                                        (nome IN super_categoria AND nome NOT IN categoria_simples)),
    PRIMARY KEY (nome));

CREATE TABLE categoria_simples 
    (nome VARCHAR(50) CHECK(nome NOT IN super_categoria),
    PRIMARY KEY (nome),
    FOREIGN KEY (nome) references categoria(nome));

CREATE TABLE super_categoria 
    (nome VARCHAR(50) NOT NULL CHECK(nome IN tem_outra(super_categoria)),
    PRIMARY KEY (nome),
    FOREIGN KEY (nome) references categoria(nome));

CREATE TABLE tem_outra
    (super_categoria VARCHAR(50) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    PRIMARY KEY (categoria),
    FOREIGN KEY (super_categoria) references super_categoria(nome),
    FOREIGN KEY (categoria) references categoria(nome)
    CHECK (super_categoria != categoria));

CREATE TABLE produto
    (ean CHAR(13) NOT NULL CHECK(ean IN tem_categoria(ean)),
    descr VARCHAR(500),
    PRIMARY KEY (ean),
    FOREIGN KEY (cat) references categoria);

CREATE TABLE tem_categoria
    (ean CHAR(13),
    nome VARCHAR(50),
    FOREIGN KEY (ean) references produto(ean),
    FOREIGN KEY (nome) references categoria(nome));

CREATE TABLE IVM
    (num_serie INTEGER,
    fabricante VARCHAR(50),
    PRIMARY KEY (num_serie, fabricante));

CREATE TABLE ponto_de_retalho
    (nome VARCHAR(50),
    distrito VARCHAR(50),
    concelho VARCHAR(50),
    PRIMARY KEY(nome));

CREATE TABLE instalada_em
    (num_serie INTEGER,
    fabricante VARCHAR(50),
    loc VARCHAR(50),
    PRIMARY KEY(num_serie, fabricante),
    FOREIGN KEY(num_serie, fabricante) references IVM(num_serie,fabricante),
    FOREIGN KEY(loc) references ponto_de_retalho(nome));

CREATE TABLE prateleira
    (nro INTEGER,
    num_serie INTEGER,
    fabricante VARCHAR(50),
    altura INTEGER,
    nome VARCHAR(50),
    PRIMARY KEY(nro, num_serie, fabricante),
    FOREIGN KEY(num_serie, fabricante) references IVM(num_serie,fabricante),
    FOREIGN KEY(nome) references categoria(nome));

CREATE TABLE planograma
    (ean CHAR(13),
    nro INTEGER,
    num_serie INTEGER,
    fabricante VARCHAR(50),
    faces INTEGER,
    unidades INTEGER,
    loc VARCHAR(50),
    PRIMARY KEY(nro, num_serie, fabricante),
    FOREIGN KEY(num_serie, fabricante, nro) references prateleira(num_serie,fabricante,nro),
    FOREIGN KEY(ean) references produto(ean));

CREATE TABLE retalhista
    (tin VARCHAR(50),
    nome VARCHAR(50) UNIQUE,
    PRIMARY KEY(tin));

CREATE TABLE responsavel_por
    (tin VARCHAR(50),
    nome_cat VARCHAR(50),
    num_serie INTEGER,
    fabricante VARCHAR(50),
    PRIMARY KEY(num_serie,fabricante),
    FOREIGN KEY(num_serie,fabricante) references IVM(num_serie,fabricante),
    FOREIGN KEY(tin) references retalhista(tin),
    FOREIGN KEY(nome_cat) references categoria(nome));

CREATE TABLE evento_reposicao
    (ean CHAR(13),
    nro INTEGER,
    num_serie INTEGER,
    fabricante VARCHAR(50),
    instante DATETIME,
    constraint max_unidades unidades INTEGER,
    tin VARCHAR(50),
    PRIMARY KEY(ean,nro,num_serie,fabricante,instante),
    FOREIGN KEY(ean,nro,num_serie,fabricante) references planograma(ean,nro,num_serie,fabricante),
    FOREIGN KEY(tin) references retalhista(tin));