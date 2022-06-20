/*1.*/
select nome from retalhista where tin = tinRet (
    select tin, count(distinct nome_cat) from responsavel_por where count >= ALL(select count(distinct nome_cat) from responsavel_por) group by tin
)

/*2*/
select nome from retalhista where tin = tinRet (
    select tin, nome_cat from responsavel_por where nome_cat = catTin(select nome from categoria_simples) group by tin
)

/*3*/
