defmodule DeliveryCenterApi.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :externalCode, :string
      add :name, :string
      add :email, :string
      add :contact, :string

      timestamps()
    end

    unique_index(:customers, [:externalCode])
  end
end
