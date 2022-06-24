drop trigger if exists cat_fun on tem_outra;
create or replace function cat_fun() returns
  trigger as $$
  declare c integer;
  begin
    select count(*) into c from tem_outra where tem_outra.super_categoria = new.categoria;
    if c > 0 then
      raise exception 'Uma categoria não pode estar contida em si propria'
      using hint = 'Por favor verifique o nome da categoria.';
    end if;
    return new;
  end;
$$ language plpgsql;

create trigger cat_trg before update on tem_outra for each row execute procedure cat_fun();
create trigger cat_trg_i before insert on tem_outra for each row execute procedure cat_fun();


drop trigger if exists uni_fun on evento_reposicao;
create or replace function uni_fun() returns
  trigger as $$
  declare c integer;
  begin
    select count(*) into c from evento_reposicao where new.unidades > (select unidades from planograma where ean = new.ean);
    if c > 0 then
      raise exception 'O numero de unidades repostas num Evento de Reposição não pode exceder o número de unidades especificado no Planograma'
      using hint = 'Por favor verifique o número de unidades a repor.';
    end if;
    return new;
  end;
$$ language plpgsql;

create trigger uni_trg before update on evento_reposicao for each row execute procedure uni_fun();
create trigger uni_trg_i before insert on evento_reposicao for each row execute procedure uni_fun();


drop trigger if exists pro_fun on planograma;
create or replace function pro_fun() returns
  trigger as $$
  declare c integer;
  begin
    select count(*) into c from planograma  where new.ean = (select ean from tem_categoria where tem_categoria.nome = (select nome from prateleira where new.nro = nro));
    if c = 0 then
      raise exception 'Um Produto só pode ser reposto numa Prateleira que apresente (pelo menos) uma das Categorias desse produto'
      using hint = 'Por favor verifique a prateleira.';
    end if;
    return new;
  end;
$$ language plpgsql;

create trigger pro_trg before update on planograma for each row execute procedure pro_fun();
create trigger pro_trg_i before insert on planograma for each row execute procedure pro_fun();


drop trigger if exists delete_on_cascade_retalhista on retalhista;
create or replace function delete_on_cascade_retalhista() returns
  trigger as $$
begin
    delete from responsavel_por where tin = old.tin;
    delete from evento_reposicao where tin = old.tin;
    return old;
end
$$ language plpgsql;

create trigger delete_on_cascade_retalhista before delete on retalhista for each row execute procedure delete_on_cascade_retalhista();


DROP TRIGGER IF EXISTS delete_on_cascade_categoria ON categoria;
CREATE OR REPLACE FUNCTION delete_on_cascade_categoria() RETURNS 
  TRIGGER AS $$
BEGIN
    DELETE FROM categoria_simples WHERE nome = old.nome;
    DELETE FROM super_categoria WHERE nome = old.nome;
    DELETE FROM tem_outra WHERE categoria = old.nome;
    DELETE FROM produto WHERE cat = old.nome;
    DELETE FROM tem_categoria WHERE nome = old.nome;
    DELETE FROM prateleira WHERE nome = old.nome;
    DELETE FROM responsavel_por WHERE nome_cat = old.nome;
    RETURN old;
END
$$ LANGUAGE plpgsql;
CREATE TRIGGER delete_on_cascade_categoria BEFORE DELETE ON categoria
FOR EACH ROW EXECUTE FUNCTION delete_on_cascade_categoria();


DROP TRIGGER IF EXISTS delete_on_cascade_super_categoria ON super_categoria;
CREATE OR REPLACE FUNCTION delete_on_cascade_super_categoria() RETURNS 
  TRIGGER AS $$
BEGIN
    DELETE FROM tem_outra WHERE super_categoria = old.nome;
    RETURN old;
END
$$ LANGUAGE plpgsql;
CREATE TRIGGER delete_on_cascade_super_categoria BEFORE DELETE ON super_categoria
FOR EACH ROW EXECUTE FUNCTION delete_on_cascade_super_categoria();


DROP TRIGGER IF EXISTS delete_on_cascade_produto ON produto;
CREATE OR REPLACE FUNCTION delete_on_cascade_produto() RETURNS 
  TRIGGER AS $$
BEGIN
    DELETE FROM planograma WHERE ean = old.ean;
    DELETE FROM tem_categoria WHERE ean = old.ean;
    RETURN old;
END
$$ LANGUAGE plpgsql;
CREATE TRIGGER delete_on_cascade_produto BEFORE DELETE ON produto FOR EACH ROW EXECUTE PROCEDURE delete_on_cascade_produto();


drop trigger if exists delete_on_cascade_IVM on IVM;
create or replace function delete_on_cascade_IVM() returns
  trigger as $$
begin
    delete from instalada_em where num_serie = old.num_serie and fabricante = old.fabricante;
    delete from prateleira where num_serie = old.num_serie and fabricante = old.fabricante;
    delete from responsavel_por where num_serie = old.num_serie and fabricante = old.fabricante;
    return old;
end
$$ language plpgsql;
create trigger delete_on_cascade_IVM before delete on IVM for each row execute procedure delete_on_cascade_IVM();

DROP TRIGGER IF EXISTS delete_on_cascade_prateleira ON prateleira;
CREATE OR REPLACE FUNCTION delete_on_cascade_prateleira() RETURNS 
  TRIGGER AS $$
BEGIN
    DELETE FROM planograma WHERE num_serie = old.num_serie AND fabricante = old.fabricante AND nro = old.nro;
    RETURN old;
END
$$ LANGUAGE plpgsql;
CREATE TRIGGER delete_on_cascade_prateleira BEFORE DELETE ON prateleira
FOR EACH ROW EXECUTE FUNCTION delete_on_cascade_prateleira();

DROP TRIGGER IF EXISTS delete_on_cascade_planograma ON planograma;
CREATE OR REPLACE FUNCTION delete_on_cascade_planograma() RETURNS 
  TRIGGER AS $$
BEGIN
    DELETE FROM evento_reposicao WHERE ean = old.ean AND nro = old.nro AND num_serie = old.num_serie AND fabricante = old.fabricante;
    RETURN old;
END
$$ LANGUAGE plpgsql;
CREATE TRIGGER delete_on_cascade_planograma BEFORE DELETE ON planograma
FOR EACH ROW EXECUTE FUNCTION delete_on_cascade_planograma();