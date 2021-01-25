defmodule DeliveryCenterApi.MarketPlaceTest do
  use DeliveryCenterApi.DataCase

  alias DeliveryCenterApi.MarketPlace

  describe "orders" do
    alias DeliveryCenterApi.MarketPlace.Order

    @valid_attrs %{
      "city" => "Cidade de Testes",
      "complement" => "teste",
      "country" => "BR",
      "customer" => %{
        "contact" => "41999999999",
        "email" => "john@doe.com",
        "externalCode" => "136226073",
        "name" => "JOHN DOE"
      },
      "deliveryFee" => "5.14",
      "district" => "Vila de Testes",
      "dtOrderCreate" => "2019-06-24T16:45:32.000-04:00",
      "externalCode" => "9987071",
      "items" => [
        %{
          "externalCode" => "IT4801901403",
          "name" => "Produto de Testes",
          "price" => 49.9,
          "quantity" => 1,
          "total" => 49.9
        }
      ],
      "latitude" => -23.629037,
      "longitude" => -46.712689,
      "number" => "3454",
      "payments" => [%{"type" => "CREDIT_CARD", "value" => 55.04}],
      "postalCode" => "85045020",
      "state" => "São Paulo",
      "storeId" => 282,
      "street" => "Rua Fake de Testes",
      "subTotal" => "49.9",
      "total" => "55.04",
      "total_shipping" => "5.14"
    }

    @invalid_attrs %{
      "city" => nil,
      "complement" => nil,
      "country" => nil,
      "customer" => %{
        "contact" => nil,
        "email" => nil,
        "externalCode" => nil,
        "name" => nil
      },
      "deliveryFee" => nil,
      "district" => nil,
      "dtOrderCreate" => nil,
      "externalCode" => nil,
      "items" => [
        %{
          "externalCode" => nil,
          "name" => nil,
          "price" => nil,
          "quantity" => nil,
          "subItems" => nil,
          "total" => nil
        }
      ],
      "latitude" => nil,
      "longitude" => nil,
      "number" => nil,
      "payments" => [%{"type" => nil, "value" => nil}],
      "postalCode" => nil,
      "state" => nil,
      "storeId" => nil,
      "street" => nil,
      "subTotal" => nil,
      "total" => nil,
      "total_shipping" => nil
    }

    test "create_order/1 with valid data creates a order" do
      {:ok, %Order{} = order} = MarketPlace.create_order(@valid_attrs)

      assert order.city == "Cidade de Testes"
      assert order.complement == "teste"
      assert order.country == "BR"
      assert order.deliveryFee == "5.14"
      assert order.district == "Vila de Testes"
      assert order.dtOrderCreate == "2019-06-24T16:45:32.000-04:00"
      assert order.externalCode == "9987071"
      assert order.latitude == Decimal.new("-23.629037")
      assert order.longitude == Decimal.new("-46.712689")
      assert order.number == "3454"
      assert order.postalCode == "85045020"
      assert order.state == "São Paulo"
      assert order.storeId == 282
      assert order.street == "Rua Fake de Testes"
      assert order.subTotal == "49.9"
      assert order.total == "55.04"
      assert order.total_shipping == "5.14"

      assert order.customer.contact == "41999999999"
      assert order.customer.email == "john@doe.com"
      assert order.customer.externalCode == "136226073"
      assert order.customer.name == "JOHN DOE"

      assert List.first(order.items).externalCode == "IT4801901403"
      assert List.first(order.items).name == "Produto de Testes"
      assert List.first(order.items).price == Decimal.new("49.9")
      assert List.first(order.items).quantity == 1
      assert List.first(order.items).total == Decimal.new("49.9")

      assert List.first(order.payments).type == "CREDIT_CARD"
      assert List.first(order.payments).value == Decimal.new("55.04")
    end

    test "list_all_orders return a list of orders" do
      MarketPlace.create_order(@valid_attrs)

      Enum.each(
        MarketPlace.list_all_orders,
        fn order ->
          assert order.city == "Cidade de Testes"
          assert order.complement == "teste"
          assert order.country == "BR"
          assert order.deliveryFee == "5.14"
          assert order.district == "Vila de Testes"
          assert order.dtOrderCreate == "2019-06-24T16:45:32.000-04:00"
          assert order.externalCode == "9987071"
          assert order.latitude == Decimal.new("-23.629037")
          assert order.longitude == Decimal.new("-46.712689")
          assert order.number == "3454"
          assert order.postalCode == "85045020"
          assert order.state == "São Paulo"
          assert order.storeId == 282
          assert order.street == "Rua Fake de Testes"
          assert order.subTotal == "49.9"
          assert order.total == "55.04"
          assert order.total_shipping == "5.14"

          assert order.customer.contact == "41999999999"
          assert order.customer.email == "john@doe.com"
          assert order.customer.externalCode == "136226073"
          assert order.customer.name == "JOHN DOE"

          assert List.first(order.items).externalCode == "IT4801901403"
          assert List.first(order.items).name == "Produto de Testes"
          assert List.first(order.items).price == Decimal.new("49.9")
          assert List.first(order.items).quantity == 1
          assert List.first(order.items).total == Decimal.new("49.9")

          assert List.first(order.payments).type == "CREDIT_CARD"
          assert List.first(order.payments).value == Decimal.new("55.04")
        end
      )
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MarketPlace.create_order(@invalid_attrs)
    end
  end
end
