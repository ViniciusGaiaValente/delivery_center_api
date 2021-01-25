defmodule DeliveryCenterApi.MarketPlace.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :city, :string
    field :complement, :string
    field :country, :string
    field :deliveryFee, :string
    field :district, :string
    field :dtOrderCreate, :string
    field :externalCode, :string
    field :latitude, :decimal
    field :longitude, :decimal
    field :number, :string
    field :postalCode, :string
    field :state, :string
    field :storeId, :integer
    field :street, :string
    field :subTotal, :string
    field :total, :string
    field :total_shipping, :string

    belongs_to :customer, DeliveryCenterApi.MarketPlace.Customer
    has_many :items, DeliveryCenterApi.MarketPlace.Item
    has_many :payments, DeliveryCenterApi.MarketPlace.Payment
    timestamps()
  end

  def changeset_assoc_existing_customer(order, attrs, customer) do
    order
    |> cast(attrs, [:externalCode, :storeId, :subTotal, :deliveryFee, :total, :total_shipping, :country, :state, :city, :district, :street, :complement, :latitude, :longitude, :dtOrderCreate, :postalCode, :number])
    |> validate_required([:externalCode, :storeId, :subTotal, :deliveryFee, :total, :total_shipping, :country, :state, :city, :district, :street, :complement, :latitude, :longitude, :dtOrderCreate, :postalCode, :number])
    |> unsafe_validate_unique(:externalCode, DeliveryCenterApi.Repo, message: "There is already an order with this external code")
    |> cast_assoc(:items)
    |> cast_assoc(:payments)
    |> put_assoc(:customer, customer)
  end

  def changeset_assoc_new_customer(order, attrs) do
    order
    |> cast(attrs, [:externalCode, :storeId, :subTotal, :deliveryFee, :total, :total_shipping, :country, :state, :city, :district, :street, :complement, :latitude, :longitude, :dtOrderCreate, :postalCode, :number])
    |> validate_required([:externalCode, :storeId, :subTotal, :deliveryFee, :total, :total_shipping, :country, :state, :city, :district, :street, :complement, :latitude, :longitude, :dtOrderCreate, :postalCode, :number])
    |> unsafe_validate_unique(:externalCode, DeliveryCenterApi.Repo, message: "There is already an order with this external code")
    |> cast_assoc(:items)
    |> cast_assoc(:payments)
    |> cast_assoc(:customer)
  end
end
