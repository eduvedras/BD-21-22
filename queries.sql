/*1.*/
select nome from retalhista where tin = tinRet (
    select tin, count(distinct nome_cat) from responsavel_por where count >= ALL(select count(distinct nome_cat) from responsavel_por)
)

/*2*/
select nome from retalhista where tin = tinRet (
    select tin, nome_cat from responsavel_por where count >= ALL(select count(distinct nome_cat) from responsavel_por)
)