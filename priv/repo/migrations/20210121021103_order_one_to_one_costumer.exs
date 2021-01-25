defmodule DeliveryCenterApi.Repo.Migrations.OrderOneToOneCustomer do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :customer_id, references(:customers)
    end

  end
end
