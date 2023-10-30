import numpy
import pandas
from datetime import date
from sqlalchemy import create_engine, URL
from sqlalchemy.types import String, Integer, Date, Float
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column
from sqlalchemy.sql import text


def main():
    engine = obter_engine()
    importar_movimentos(engine)
    importar_saldos(engine)
    exportar_relatorio(engine)

def obter_engine():
    url_object = URL.create(
        "postgresql+pg8000",
        username="saranahra",
        password="1234",
        host="localhost",
        database="domrock",
    )
    engine = create_engine(url_object, echo=True)
    print(" -- conexão com o banco de dados iniciada.")
    return engine
    
def importar_movimentos(engine):
    caminho_arquivo_movimentacao = "C:/Users/saran/OneDrive/Desktop/Desafio Dom Rock/dom-rock-desafio-main/projeto-domrock/projeto_domrock/dados/MovtoITEM.xlsx"
    dataframe = pandas.read_excel(caminho_arquivo_movimentacao)
    dataframe.to_sql("Movimentos", engine, if_exists="replace")
    print(" -- movimentos importados para o sql")
    
def importar_saldos(engine):
    caminho_arquivo_saldo = "C:/Users/saran/OneDrive/Desktop/Desafio Dom Rock/dom-rock-desafio-main/projeto-domrock/projeto_domrock/dados/SaldoITEM.xlsx"
    dataframe = pandas.read_excel(caminho_arquivo_saldo)
    dataframe.to_sql("Saldos", engine, if_exists="replace")
    print(" -- saldos importados para o sql")

def calcular_saldo(engine):
    consulta_saldo_sql = open("C:/Users/saran/OneDrive/Desktop/Desafio Dom Rock/dom-rock-desafio-main/projeto-domrock/projeto_domrock/sql/query-tentativa3-saldo.sql", "r").read()
    consulta_valores_diarios_acumulados_sql = open("C:/Users/saran/OneDrive/Desktop/Desafio Dom Rock/dom-rock-desafio-main/projeto-domrock/projeto_domrock/sql/query-tentativa3-valores-diarios-acumulados.sql", "r").read()
    dataframe_saldo = pandas.read_sql(consulta_saldo_sql,engine)
    dataframe_valores_diarios_acumualdos = pandas.read_sql(consulta_valores_diarios_acumulados_sql, engine)
    dataframe.toarray
    for item in dataframe_saldo.iterrows():
        saldo_inicial_valor = item[1]['saldo_inicial_valor']
        saldo_inicial_qtd = item[1]['saldo_inicial_qtd']
        for movimento in dataframe_valores_diarios_acumulados.iterrrows():
            entrada_qtd = movimento[1]['lancamento_entrada_qtd']
            entrada_valor = movimento[1]['lancamento_entrada_valor']
            saida_qtd = movimento[1]['lancamento_saida_qtd']
            saida_valor = movimento[1]['lancamento_saida_valor']

def exportar_relatorio(engine):
    consulta_sql = open("C:/Users/saran/OneDrive/Desktop/Desafio Dom Rock/dom-rock-desafio-main/projeto-domrock/projeto_domrock/sql/query-tentativa2-saldo-final-anual.sql", "r").read()
    dataframe = pandas.read_sql(consulta_sql,engine)
    dataframe.to_csv("C:/Users/saran/OneDrive/Desktop/Desafio Dom Rock/dom-rock-desafio-main/projeto-domrock/projeto_domrock/resultado/relatorio.csv")
    dataframe.to_excel("C:/Users/saran/OneDrive/Desktop/Desafio Dom Rock/dom-rock-desafio-main/projeto-domrock/projeto_domrock/resultado/relatorio.xlsx")
    print(dataframe)
    print(" -- relatório exportado para o excel")
