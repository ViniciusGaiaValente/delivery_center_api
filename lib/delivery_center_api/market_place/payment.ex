defmodule DeliveryCenterApi.MarketPlace.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :type, :string
    field :value, :decimal

    belongs_to :order, DeliveryCenterApi.MarketPlace.Order
    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:type, :value])
    |> validate_required([:type, :value])
  end
end
