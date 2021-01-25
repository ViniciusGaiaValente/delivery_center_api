defmodule DeliveryCenterApi.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :externalCode, :string
      add :storeId, :integer
      add :subTotal, :string
      add :deliveryFee, :string
      add :total, :string
      add :total_shipping, :string
      add :country, :string
      add :state, :string
      add :city, :string
      add :district, :string
      add :street, :string
      add :complement, :string
      add :latitude, :decimal
      add :longitude, :decimal
      add :dtOrderCreate, :string
      add :postalCode, :string
      add :number, :string

      timestamps()
    end

    unique_index(:orders, [:externalCode])
  end
end
