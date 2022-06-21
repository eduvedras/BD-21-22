CREATE TABLE tempo
    (ano VARCHAR(50),
    trimestre VARCHAR(50),
    mes VARCHAR(50),
    dia_mes VARCHAR(50),
    dia_semana VARCHAR(50),
    PRIMARY KEY(ano, trimestre, mes,dia_mes,dia_semana),
    ano EXTRACT(YEAR from evento_reposicao.instante)),trimestre = (select EXTRACT(QUARTER from evento_reposicao.instante)),
    mes = (select EXTRACT(MONTH from evento_reposicao.instante)), dia_mes = (select EXTRACT(DAY from evento_reposicao.instante)),
    dia_semana = (select EXTRACT(DOW from evento_reposicao.instante)));



create view vendas(ean,cat,ano,trimestre,mes,dia_mes,dia_semana,distrito,concelho,unidades) as
select ean, ano,trimestre,mes,dia_mes,dia_semana, distrito,concelho,unidades from produto natural join categoria
natural join evento_reposicao natural join ponto_de_retalho;

/*ano = (select EXTRACT(YEAR from instante)),trimestre = (select EXTRACT(QUARTER from instante)),
mes = (select EXTRACT(MONTH from instante)), dia_mes = (select EXTRACT(DAY from instante)),
dia_semana = (select EXTRACT(DOW from instante));*/
/*
select cat from categoria,
select ano from EXTRACT(YEAR from evento_reposicao.instante),
select trimestre from EXTRACT(QUARTER from evento_reposicao.instante),
select mes from EXTRACT(MONTH from evento_reposicao.instante),
select dia_mes from EXTRACT(DAY from evento_reposicao.instante),
select dia_semana from EXTRACT(DOW from evento_reposicao.instante),
select distrito,concelho from ponto_de_retalho,
select unidades from evento_reposicao;*/