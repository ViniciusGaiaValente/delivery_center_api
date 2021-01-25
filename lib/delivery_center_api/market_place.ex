defmodule DeliveryCenterApi.MarketPlace do
  @moduledoc """
  The MarketPlace context.

    This module aggregates the database operations related to the Order entity
  """

  import Ecto.Query, warn: false
  alias DeliveryCenterApi.Repo

  alias DeliveryCenterApi.MarketPlace.Order
  alias DeliveryCenterApi.MarketPlace.Customer

  @doc """
    Return the list of all the order records saved on the database, along with the customer, items and payments associated with each one of them.
  """
  def list_all_orders do
    Repo.all(Order)
    |> Repo.preload([:customer, :items, :payments])
  end

  @doc """
    Receive a map representing an 'order' object on the 'attrs' param.
    Create a record on the database with the following objects:
      - Order (the attrs map itself)
      - Items ('items' property on attrs)
      - Payments ('payments' property on attrs).
    Check if the received customer ('buyer' property on attrs) already exists on the database.
    If so, associate the just created order to this existing customer.
    If not, create a new customer at the database and associate it to the just created order.
    The difference between the existing customer and the new customer situation is the strategy used the associate the entities.
    On the existing customer situation, the association is accomplished by put_assoc function.
    On the new customer situation, the association is accomplished by build_assoc function.
  """
  def create_order(attrs \\ %{}) do
    case attrs do

      %{ "customer" => %{ "externalCode" => costumErexternalCode } } ->

        case get_customer_by_external_code(costumErexternalCode) do

          nil -> create_order_with_new_customer(attrs)

          customer -> create_order_with_existing_customer(attrs, customer)

        end

      _ -> create_order_with_new_customer(attrs)

    end
  end

  @doc """
    Receive an external code as a param.
    Check if it's nil.
    If so, return nil.
    If not, look for a customer that matches the received external code and return it.
  """
  def get_customer_by_external_code(externalCode) do
    case externalCode do
      nil -> nil
      _ -> Repo.get_by(Customer, externalCode: externalCode)
    end
  end

  defp create_order_with_new_customer(attrs) do
    %Order{}
    |> Order.changeset_assoc_new_customer(attrs)
    |> Repo.insert()
  end

  defp create_order_with_existing_customer(attrs, customer) do
    %Order{}
    |> Order.changeset_assoc_existing_customer(attrs, customer)
    |> Repo.insert()
  end
end
