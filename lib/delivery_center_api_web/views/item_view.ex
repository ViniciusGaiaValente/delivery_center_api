defmodule DeliveryCenterApiWeb.ItemView do
  use DeliveryCenterApiWeb, :view
  alias DeliveryCenterApiWeb.ItemView

  def render("index.json", %{items: items}) do
    %{data: render_many(items, ItemView, "item.json")}
  end

  def render("show.json", %{item: item}) do
    %{data: render_one(item, ItemView, "item.json")}
  end

  def render("item.json", %{item: item}) do
    %{id: item.id,
      externalCode: item.externalCode,
      name: item.name,
      price: item.price,
      quantity: item.quantity,
      total: item.total}
  end
end
