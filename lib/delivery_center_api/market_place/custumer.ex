defmodule DeliveryCenterApi.MarketPlace.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :contact, :string
    field :email, :string
    field :externalCode, :string
    field :name, :string

    has_many :order, DeliveryCenterApi.MarketPlace.Order
    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:externalCode, :name, :email, :contact])
    |> unsafe_validate_unique(:externalCode, DeliveryCenterApi.Repo)
    |> validate_required([:externalCode, :name, :email, :contact])
  end
end
