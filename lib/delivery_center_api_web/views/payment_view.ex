defmodule DeliveryCenterApiWeb.PaymentView do
  use DeliveryCenterApiWeb, :view
  alias DeliveryCenterApiWeb.PaymentView

  def render("index.json", %{payments: payments}) do
    %{data: render_many(payments, PaymentView, "payment.json")}
  end

  def render("show.json", %{payment: payment}) do
    %{data: render_one(payment, PaymentView, "payment.json")}
  end

  def render("payment.json", %{payment: payment}) do
    %{id: payment.id,
      type: payment.type,
      value: payment.value}
  end
end
