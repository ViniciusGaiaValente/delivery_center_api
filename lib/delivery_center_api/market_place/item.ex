defmodule DeliveryCenterApi.MarketPlace.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :externalCode, :string
    field :name, :string
    field :price, :decimal
    field :quantity, :integer
    field :total, :decimal

    belongs_to :order, DeliveryCenterApi.MarketPlace.Order
    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:externalCode, :name, :price, :quantity, :total])
    |> validate_required([:externalCode, :name, :price, :quantity, :total])
  end
end
