defmodule DeliveryCenterApi.Parser do
  @moduledoc """
  The Parser context.
  """

  @doc """
    Receives an input payload and parse it to a map on the Order entity format.
  """
  def parse_order(payload) do
    %{
      "city" => payload["shipping"]["receiver_address"]["city"]["name"],
      "complement" => payload["shipping"]["receiver_address"]["comment"],
      "country" => payload["shipping"]["receiver_address"]["country"]["id"],
      "deliveryFee" => to_string(payload["total_shipping"]),
      "district" => payload["shipping"]["receiver_address"]["neighborhood"]["name"],
      "dtOrderCreate" => payload["date_created"],
      "externalCode" => to_string(payload["id"]),
      "latitude" => payload["shipping"]["receiver_address"]["latitude"],
      "longitude" => payload["shipping"]["receiver_address"]["longitude"],
      "number" => payload["shipping"]["receiver_address"]["street_number"],
      "postalCode" => payload["shipping"]["receiver_address"]["zip_code"],
      "state" => payload["shipping"]["receiver_address"]["state"]["name"],
      "storeId" => payload["store_id"],
      "street" => payload["shipping"]["receiver_address"]["street_name"],
      "subTotal" => to_string(payload["total_amount"]),
      "total" => to_string(payload["total_amount_with_shipping"]),
      "total_shipping" => to_string(payload["total_shipping"]),
      "customer" => %{
        "contact" => "#{payload["buyer"]["phone"]["area_code"]}#{payload["buyer"]["phone"]["number"]}",
        "email" => payload["buyer"]["email"],
        "externalCode" => to_string(payload["buyer"]["id"]),
        "name" => payload["buyer"]["nickname"]
      },
      "items" => parse_items(payload["order_items"]),
      "payments" => parse_payments(payload["payments"]),
    }
  end

  defp parse_items(items) do
    case is_list(items) do
      false -> nil
      true ->
        Enum.map(
          items,
          fn item ->
            %{
              "externalCode" => item["item"]["id"],
              "name" => item["item"]["title"],
              "price" => item["unit_price"],
              "quantity" => item["quantity"],
              "total" => item["quantity"] * item["unit_price"]
            }
          end
        )
    end
  end

  defp parse_payments(payments) do
    case is_list(payments) do
      false -> nil
      true ->
        Enum.map(
          payments,
          fn payment ->
            %{"type" => String.upcase(payment["payment_type"]), "value" => payment["total_paid_amount"]}
          end
        )
    end
  end
end
