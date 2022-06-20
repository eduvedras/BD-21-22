/*1.*/
select nome from retalhista where tin = tinRet (
    select tin, count(distinct nome_cat) from responsavel_por where count >= ALL(select count(distinct nome_cat) from responsavel_por) group by tin
)

/*2*/
select retalhista.nome 
from categoria_simples join responsavel_por on categoria_simples.nome = responsavel_por.nome_cat
join retalhista on retalhista.tin = responsavel_por.tin
group by retalhista.nome

/*igual a 2?*/
select nome from retalhista where tin in (select tin from responsavel_por group by tin having count(*)=ALL(select count(*)
    from categoria_simples));

/*3*/
select ean from produto where ean not in (select ean from evento_reposicao);

/*4*/
select ean from evento_reposicao group by ean having count(distinct tin) = 1;