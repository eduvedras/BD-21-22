create view vendas(ean,cat,ano,trimestre,mes,dia_mes,dia_semana,distrito,concelho,unidades) as
select ean from produto,
select cat from categoria,
select ano from EXTRACT(YEAR from evento_reposicao.instante),
select trimestre from EXTRACT(QUARTER from evento_reposicao.instante),
select mes from EXTRACT(MONTH from evento_reposicao.instante),
select dia_mes from EXTRACT(DAY from evento_reposicao.instante),
select dia_semana from EXTRACT(DOW from evento_reposicao.instante),
select distrito,concelho from ponto_de_retalho,
select unidades from evento_reposicao;