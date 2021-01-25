# Delivery Center API 

## Sobre

O projeto foi desenvolvido com elixir e phoenix, seguindo os padrões do framework.

## Informações pessoais

  - *Nome*: Vinicius Valente
  - *Email*: viniciusgaiavalente@gmail.com
  - *Telefone*: (91) 98441-8961

# Configuracao do projeto

## API

Para executar esse projeto você precisa instalar e configurar corretamente o elixir e o phoenix framework na sua maquina. Caso ainda não tenha feito o processo, siga os seguintes passos descritos em:

  - [Instalando o Elixir](https://elixir-lang.org/install.html).
  - [Instalando o Phoenix](https://hexdocs.pm/phoenix/installation.html).

Com tudo instalado rode o comando 'mix deps.get' dentro da pasta do projeto:

```bash
cd bill_splitter/
mix deps.get
```

## Banco de dados

Esse projeto foi configurado para utilizar o banco de dados postgres, porém outros bancos de dados suportados pelo Ecto funcionarão normalmente (MySQL, MSSQL).

Insira as informações do banco de dados que deseja utilizar no arquivo **config/dev.exs**:

```elixir
config :delivery_center_api, DeliveryCenterApi.Repo,
    username: "postgres",
    password: "postgres",
    database: "delivery_center_api_dev",
    hostname: "localhost",
    show_sensitive_data_on_connection_error: true,
    pool_size: 10
```

Caso ainda náo tenha um banco de dados postgres pronto para uso, você pode configura-lo facilmente utilizando o docker.
 - Para instalar o docker siga os seguintes passos descritos em: [Instalando o Docker](https://docs.docker.com/engine/install/).

Com o docker instalado faça o pull da imagem do postgres:

```bash
docker pull postgres
```

E então rode o comando a seguir:

```bash
docker run --name delivery-center-api-db -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -e POSTGRES_DB=delivery_center_api_dev -d postgres
```

Esse comando cria e executa um container contendo um banco de dados postgres já com as configurações pré-existente no arquivo config/dev.exs.

Com o banco de dados online e as informações de conexão inseridas corretamente, rode o seguinte comando para criar o banco de dados:

```bash
mix ecto.create database
```

Depois rode todas as migrations:

```bash
mix ecto.migrate
```

Com isso a API está pronta para ser executada com o comando 'mix phx.server'.

# Utilizando a aplicação

Existem duas operações expostas por essa api:

  - POST para localhost:4000/api/order

Esta operação recebe um payload no corpo da requisição como json, como o descrito a seguir:

```json
{
  "id": 9987071,
  "store_id": 282,
  "date_created": "2019-06-24T16:45:32.000-04:00",
  "date_closed": "2019-06-24T16:45:35.000-04:00",
  "last_updated": "2019-06-25T13:26:49.000-04:00",
  "total_amount": 49.9,
  "total_shipping": 5.14,
  "total_amount_with_shipping": 55.04,
  "paid_amount": 55.04,
  "expiration_date": "2019-07-22T16:45:35.000-04:00",
  "total_shipping": 5.14,
  "order_items": [
    {
      "item": {
        "id": "IT4801901403",
        "title": "Produto de Testes"
      },
      "quantity": 1,
      "unit_price": 49.9,
      "full_unit_price": 49.9
    }
  ],
  "payments": [
    {
      "id": 12312313,
      "order_id": 9987071,
      "payer_id": 414138,
      "installments": 1,
      "payment_type": "credit_card",
      "status": "paid",
      "transaction_amount": 49.9,
      "taxes_amount": 0,
      "shipping_cost": 5.14,
      "total_paid_amount": 55.04,
      "installment_amount": 55.04,
      "date_approved": "2019-06-24T16:45:35.000-04:00",
      "date_created": "2019-06-24T16:45:33.000-04:00"
    }
  ],
  "shipping": {
    "id": 43444211797,
    "shipment_type": "shipping",
    "date_created": "2019-06-24T16:45:33.000-04:00",
    "receiver_address": {
      "id": 1051695306,
      "address_line": "Rua Fake de Testes 3454",
      "street_name": "Rua Fake de Testes",
      "street_number": "3454",
      "comment": "teste",
      "zip_code": "85045020",
      "city": {
        "name": "Cidade de Testes"
      },
      "state": {
        "name": "São Paulo"
      },
      "country": {
        "id": "BR",
        "name": "Brasil"
      },
      "neighborhood": {
        "id": null,
        "name": "Vila de Testes"
      },
      "latitude": -23.629037,
      "longitude": -46.712689,
      "receiver_phone": "41999999999"
    }
  },
  "status": "paid",
  "buyer": {
    "id": 136226073,
    "nickname": "JOHN DOE",
    "email": "john@doe.com",
    "phone": {
      "area_code": 41,
      "number": "999999999"
    },
    "first_name": "John",
    "last_name": "Doe",
    "billing_info": {
      "doc_type": "CPF",
      "doc_number": "09487965477"
    }
  }
}
```

Depois, realiza o parse deste payload para o seguinte formato:

```json
{
  "externalCode": "9987071",
  "storeId": 282,
  "subTotal": "49.90",
  "deliveryFee": "5.14",
  "total": "55.04",
  "country": "BR",
  "state": "SP",
  "city": "Cidade de Testes",
  "district": "Bairro Fake",
  "street": "Rua de Testes Fake",
  "complement": "galpao",
  "latitude": -23.629037,
  "longitude":  -46.712689,
  "dtOrderCreate": "2019-06-27T19:59:08.251Z",
  "postalCode": "85045020",
  "number": "0",
  "customer": {
    "externalCode": "136226073",
    "name": "JOHN DOE",
    "email": "john@doe.com",
    "contact": "41999999999",
  },
  "items": [
    {
      "externalCode": "IT4801901403",
      "name": "Produto de Testes",
      "price": 49.9,
      "quantity": 1,
      "total": 49.9,
      "subItems": []
    }
  ],
  "payments": [
    {
      "type": "CREDIT_CARD",
      "value": 55.04
    }
  ]
}
```

E então os dados transformados são enviados para uma api externa (https://delivery-center-recruitment-ap.herokuapp.com/) que realiza algumas validações e em caso de erro, retorna a mensagem original.

Com os dados validados, os mesmo são salvos no banco de dados e deoois retornados.

  - GET para localhost:4000/api/order

Esta operação lista todos os pedidos ('Orders') salvos no banco de dados, assim como os 'Items', 'Payments' e o 'Customer' associados ao mesmo. Os json de retorno, segue o padrão descrito a seguir:

```json
{
  "data": {
    "city": "Cidade de Testes",
    "complement": "teste",
    "country": "BR",
    "customer": {
      "contact": "41999999999",
      "email": "john@doe.com",
      "externalCode": "136226075",
      "id": 3,
      "name": "JOHN DOE"
    },
    "deliveryFee": "5.14",
    "district": "Vila de Testes",
    "dtOrderCreate": "2019-06-24T16:45:32.000-04:00",
    "externalCode": "9987079",
    "id": 7,
    "items": [
      {
        "externalCode": "IT4801901403",
        "id": 7,
        "name": "Produto de Testes",
        "price": "49.9",
        "quantity": 1,
        "total": "49.9"
      }
    ],
    "latitude": "-23.629037",
    "longitude": "-46.712689",
    "number": "3454",
    "payments": [
      {
        "id": 7,
        "type": "CREDIT_CARD",
        "value": "55.04"
      }
    ],
    "postalCode": "85045020",
    "state": "São Paulo",
    "storeId": 282,
    "street": "Rua Fake de Testes",
    "subTotal": "49.9",
    "total": "55.04",
    "total_shipping": "5.14"
  }
}
```

## Testando a aplicação

Os testes para esta API encontram-se organizados dentro da pasta /test. Foram construidos utilizando o framework **ExUnit**

  - Para Executar a suite de testes rode o comando:

```bash
mix test
```