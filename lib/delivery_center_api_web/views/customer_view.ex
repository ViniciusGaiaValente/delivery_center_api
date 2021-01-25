defmodule DeliveryCenterApiWeb.CustomerView do
  use DeliveryCenterApiWeb, :view
  alias DeliveryCenterApiWeb.CustomerView

  def render("index.json", %{customers: customers}) do
    %{data: render_many(customers, CustomerView, "customer.json")}
  end

  def render("show.json", %{customer: customer}) do
    %{data: render_one(customer, CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{id: customer.id,
      externalCode: customer.externalCode,
      name: customer.name,
      email: customer.email,
      contact: customer.contact}
  end
end
