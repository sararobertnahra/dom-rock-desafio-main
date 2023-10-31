# dom-rock-desafio

Para iniciar o desafio, foi criado um repositório no GitHub para armazenar os códigos desenvolvidos. O banco de dados utilizado no desafio foi o Postgres. Além disso, foram empregados o Docker e o Poetry para criar o ambiente de desenvolvimento (container). As principais bibliotecas utilizados foram: pandas e sqlalchemy.

Para executar a aplicação é necessário levantar o container do banco de dados.
Na pasta contendo o docker-compose.yaml, digitar o seguinte comando:

```Terminal
docker compose up
```

Para rodar o script, acesse a pasta projeto-domrock, que contém o pyproject.toml e digite:
```Terminal
poetry run dev
```
Foram gerados 2 relatórios finais, sendo um no formato `.csv` e o outro no formato `.xlsx`
Estes relatórios contém:
- item em formato de texto,
- a data de lançamento no formato dd/mm/yyyy,
- Lançamento de entrada: quantidade, em formato decimal,
- Lançamento de entrada: valor, em formato decimal,
- Lançamento de saída: quantidade, em formato decimal,
- Lançamento de saída: valor, em formato decimal,
- Saldo inicial em quantidade, em formato decimal,
- Saldo inicial em valor, em formaro decimal,
- Saldo final em quantidade, em formato decimal,
- Saldo final em valor, em formaro decimal

