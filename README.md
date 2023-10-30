# dom-rock-desafio

Para iniciar o desafio, foi criado um repositório no GitHub para armazenar os códigos desenvolvidos. O banco de dados utilizado no desafio foi o SQLAlchemy. Além disso, foram empregados o Docker e o Poetry para criar o ambiente de desenvolvimento (container).

Para rodar o script foi utilizado o seguinte comando:
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

As bibliotecas utilizadas foram: numpy, pandas, datetime importando date, sqlalchemy importando engine e URL, sqlalchemy.types importnado String, Integer, Date e Float, sqlalchemy.orm importando DeclarativeBase, Mapped e mapped_column, sqlalchemy.sql importando text

