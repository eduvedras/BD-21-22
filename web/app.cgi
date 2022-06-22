#!/usr/bin/python3
from unicodedata import category
from wsgiref.handlers import CGIHandler
from flask import Flask
from flask import render_template, request, redirect
import psycopg2
import psycopg2.extras

## SGBD configs
DB_HOST = "db.tecnico.ulisboa.pt"
DB_USER = "ist195666"
DB_DATABASE = DB_USER
DB_PASSWORD = "password"
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s" % (
    DB_HOST,
    DB_DATABASE,
    DB_USER,
    DB_PASSWORD,
)

app = Flask(__name__)


@app.route("/")
def main():
    try:
        return render_template("index.html")
    except Exception as e:
        return str(e)  # Renders a page with the error.


@app.route("/categorias")
def listar_categorias():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT * FROM categoria;"
        cursor.execute(query)
        return render_template("categorias.html", cursor=cursor)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()

@app.route("/categorias/remove")
def remover_categoria():
    dbConn = None
    cursor = None
    try:
        
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        categoria = request.args.get('categoria')
        query = "DELETE CASCADE categoria=%s;"
        data = (categoria)
        cursor.execute(query, data)
        return render_template("categorias.html", cursor=categoria) #change me
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()

@app.route("/categorias/select")
def listar_categoria_selecionada():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        categoria = request.form["select"]
        data = (categoria)
        query = "SELECT * from tem_outra WHERE super_categoria=%s;"
        cursor.execute(query,data)
        return render_template("sub_cat.html", cursor=cursor)
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()

@app.route("/categorias/inserir_cat")
def inserir_categoria():
    dbConn = None
    cursor = None
    try:
        return render_template("inserir_cat.html")
    except Exception as e:
        return str(e)

@app.route("/categorias/inserir_subcat")
def inserir_categoria():
    dbConn = None
    cursor = None
    try:
        return render_template("inserir_subcat.html")
    except Exception as e:
        return str(e)


@app.route('/categorias/execute_insert', methods=["POST"])
def insert_categoria_intoDB():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "INSERT INTO categoria VALUES (%s);"
    data = (request.form["nome"],)
    cursor.execute(query,data)
    return redirect(url_for('categorias.html'))
  except Exception as e:
    return redirect(url_for('erro'))
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()


@app.route('/categorias/execute_insert_sub', methods=["POST"])
def insert_categoriasub_intoDB():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query1 = "INSERT INTO categoria VALUES (%s);"
    query2 = "INSERT INTO categoria_simples VALUES (%s,%s);"
    data1 = (request.form["nome"],)
    data2 = (request.form["nome"],request.form["nome_super"],)
    cursor.execute(query1,data1)
    cursor.execute(query2,data2)
    return redirect(url_for('categorias.html'))
  except Exception as e:
    return redirect(url_for('erro'))
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()

@app.route("/IVM")
def listar_IVM():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT * from IVM;"
        cursor.execute(query)
        return render_template("IVM.html", cursor=cursor)
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()

@app.route("/IVM/select")
def listar_IVM_selecionada():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        IVM = request.form["select"]
        data = (IVM)
        query = "SELECT * from IVM=%s;"
        cursor.execute(query,data)
        return render_template("eventos_rep.html", cursor=cursor)
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()

@app.route("/retalhistas")
def listar_retalhistas():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT * FROM retalhista;"
        cursor.execute(query)
        return render_template("retalhistas.html", cursor=cursor)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()

@app.route("/retalhistas/inserir")
def inserir_categoria():
    dbConn = None
    cursor = None
    try:
        return render_template("inserir_retalhista.html")
    except Exception as e:
        return str(e)

@app.route('/retalhistas/execute_insert', methods=["POST"])
def insert_retalhista_intoDB():
  dbConn=None
  cursor=None
  try:
    dbConn = psycopg2.connect(DB_CONNECTION_STRING)
    cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)
    query = "INSERT INTO retalhista VALUES (%s,%s);"
    data = (request.form["tin"],request.form["nome"],)
    cursor.execute(query,data)
    return redirect(url_for('retalhistas.html'))
  except Exception as e:
    return redirect(url_for('erro'))
  finally:
    dbConn.commit()
    cursor.close()
    dbConn.close()


@app.route("/retalhistas/remove")
def remover_categoria():
    dbConn = None
    cursor = None
    try:
        
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        categoria = request.args.get('retalhista')
        query = "DELETE CASCADE retalhista=%s;"
        data = (categoria)
        cursor.execute(query, data)
        return render_template("retalhistas.html", cursor=retalhista) 
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()

CGIHandler().run(app)
