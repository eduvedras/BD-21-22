insert into categoria values ('Fruta');
insert into categoria values ('Vegetal');
insert into categoria values ('Bolachas');
insert into categoria values ('Carne');
insert into categoria values ('Peixe');
insert into categoria values ('Flor');
insert into categoria values ('Banana');
insert into categoria values ('Chocolate');
insert into categoria values ('Kit kat');
insert into categoria values ('Twix');
insert into categoria values ('Oreo');
insert into categoria values ('Melancia');
insert into categoria values ('Melão');
insert into categoria values ('Cereja');
insert into categoria values ('Alface');

insert into categoria_simples values ('Cereja');
insert into categoria_simples values ('Alface');
insert into categoria_simples values ('Oreo');
insert into categoria_simples values ('Melão');
insert into categoria_simples values ('Melancia');
insert into categoria_simples values ('Twix');
insert into categoria_simples values ('Kit kat');
insert into categoria_simples values ('Banana');

insert into super_categoria values ('Fruta');
insert into super_categoria values ('Vegetal');
insert into super_categoria values ('Bolachas');
insert into super_categoria values ('Carne');
insert into super_categoria values ('Peixe');
insert into super_categoria values ('Flor');
insert into super_categoria values ('Chocolate');

insert into tem_outra values ('Fruta',	 'Banana');
insert into tem_outra values ('Fruta', 'Cereja');
insert into tem_outra values ('Fruta',	 'Melão');
insert into tem_outra values ('Fruta', 'Melancia');
insert into tem_outra values ('Bolachas',	 'Oreo');
insert into tem_outra values ('Vegetal', 'Alface');
insert into tem_outra values ('Chocolate',   'Twix');
insert into tem_outra values ('Chocolate',	 'Kit kat');

insert into produto values ('1234567890123','Banana da madeira');
insert into produto values ('2345678901234', 'Gelado oreo');
insert into produto values ('3456789012345', 'Kit kat max');
insert into produto values ('4567890123456', 'Melancia de verão');
insert into produto values ('5678901234567', 'Alface fresca');
insert into produto values ('6789012345678', 'Cereja fresca');
insert into produto values ('7890123456789', 'Banana de barco');
insert into produto values ('8901234567890', 'Bolacha Oreo');
insert into produto values ('9012345678901', 'Banana de avião');

insert into tem_categoria values ('1234567890123','Banana');
insert into tem_categoria values ('2345678901234',	'Bolacha');
insert into tem_categoria values ('3456789012345',	'Oreo');
insert into tem_categoria values ('4567890123456',	'Melancia');
insert into tem_categoria values ('5678901234567',  'Alface');
insert into tem_categoria values ('6789012345678',	'Cereja');
insert into tem_categoria values ('7890123456789',	'Banana');
insert into tem_categoria values ('8901234567890',	'Bolacha');
insert into tem_categoria values ('9012345678901',	'Banana');

insert into IVM values (1,'F1');
insert into IVM values (2,	'F2');
insert into IVM values (3,	'F3');
insert into IVM values (4,	'F4');

insert into ponto_de_retalho values ('Colombo','Lisboa','Lisboa');
insert into ponto_de_retalho values ('Estadio do Dragão',	'Porto', 'Vila Nova de Gaia');
insert into ponto_de_retalho values ('Loja do ze',	'Lisboa', 'Torres Vedras');
insert into ponto_de_retalho values ('Grab and Go',	'Braga', 'Braga');

insert into instalada_em values (1,'F1','Colombo');
insert into instalada_em values (2,	'F2', 'Estadio do Dragão');
insert into instalada_em values (3,	'F3', 'Loja do ze');
insert into instalada_em values (4,	'F4', 'Grab and Go');

insert into prateleira values (1,1,   'F1','Banana');
insert into prateleira values (2,1,   'F1','Melancia');
insert into prateleira values (3,1,   'F1','Oreo');
insert into prateleira values (1,2,	'F2', 'Melancia');
insert into prateleira values (1,3,	'F3', 'Alface');
insert into prateleira values (1,3,	'F3', 'Fruta');
insert into prateleira values (1,4,	'F4', 'Oreo');
insert into prateleira values (1,4,	'F4', 'Bolachas');

insert into planograma values ('1234567890123',1,1,   'F1',2,5,'Colombo');
insert into planograma values ('4567890123456',2,2,   'F2',3,6,'Estadio do Dragão');
insert into planograma values ('5678901234567',1,3,   'F3',1,4,'Loja do ze');
insert into planograma values ('3456789012345',3,4,	'F4',3,7, 'Grab and Go');

insert into retalhista values ('id1','José');
insert into retalhista values ('id2','João');
insert into retalhista values ('id3','Jorge');
insert into retalhista values ('id4','Acácio');

insert into responsavel_por values ('id1','Banana',1,'F1');
insert into responsavel_por values ('id1','Oreo',1,'F1');
insert into responsavel_por values ('id2','Alface',3,'F3');
insert into responsavel_por values ('id2','Banana',1,'F1');
insert into responsavel_por values ('id3','Melancia',2,'F2');
insert into responsavel_por values ('id4','Bolachas',4,'F4');

insert into evento_reposicao values ('1234567890123',1,1,'F1','2018-7-1 19:42:50',3,'id1');
insert into evento_reposicao values ('4567890123456',2,1,'F1','2016-8-1 15:42:50',2,'id1');
insert into evento_reposicao values ('1234567890123',1,1,'F1','2017-8-1 15:42:50',3,'id2');
insert into evento_reposicao values ('8901234567890',3,1,'F1','2017-8-6 15:42:50',3,'id1');
