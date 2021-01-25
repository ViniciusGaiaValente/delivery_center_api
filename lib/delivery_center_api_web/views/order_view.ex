defmodule DeliveryCenterApiWeb.OrderView do
  use DeliveryCenterApiWeb, :view
  alias DeliveryCenterApiWeb.OrderView
  alias DeliveryCenterApiWeb.CustomerView
  alias DeliveryCenterApiWeb.ItemView
  alias DeliveryCenterApiWeb.PaymentView

  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{
      id: order.id,
      externalCode: order.externalCode,
      storeId: order.storeId,
      subTotal: order.subTotal,
      deliveryFee: order.deliveryFee,
      total: order.total,
      total_shipping: order.total_shipping,
      country: order.country,
      state: order.state,
      city: order.city,
      district: order.district,
      street: order.street,
      complement: order.complement,
      latitude: order.latitude,
      longitude: order.longitude,
      dtOrderCreate: order.dtOrderCreate,
      postalCode: order.postalCode,
      number: order.number,
      customer: CustomerView.render("customer.json", %{ customer: order.customer }),
      items: ItemView.render("index.json", %{ items: order.items }).data,
      payments: PaymentView.render("index.json", %{ payments: order.payments }).data
    }
  end

  def render("error.json", %{message: message}) do
    %{ message: message }
  end
end
