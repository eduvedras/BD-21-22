/*1 artigos vendidos num dado período (i.e. entre duas datas), por dia da semana, por concelho e no total*/
SELECT ean,cat,ano,trimestre,mes,dia_mes,dia_semana,distrito,concelho,unidades, COUNT(*) AS TOTAL
FROM vendas
GROUP BY
GROUPING SETS ( (ano), (P#) ) ;
/*2 artigos vendidos num dado distrito (i.e. “Lisboa”), por concelho, categoria, dia da semana e no total*/