defmodule DeliveryCenterApi.Repo.Migrations.OrderOneToManyItens do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add :order_id, references(:orders)
    end

  end
end
