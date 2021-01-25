defmodule DeliveryCenterApiWeb.OrderController do
  use DeliveryCenterApiWeb, :controller

  alias DeliveryCenterApi.Parser
  alias DeliveryCenterApi.MarketPlace
  alias DeliveryCenterApi.MarketPlace.Order
  use Timex

  action_fallback DeliveryCenterApiWeb.FallbackController

  def index(conn, _params) do
    with orders <- MarketPlace.list_all_orders do
      conn
      |> put_status(:ok)
      |> render("index.json", orders: orders)
    end
  end

  def create(conn, params) do
    parsed_order = Parser.parse_order(params)

    case {
      Timex.format(Timex.now, "{h24}h{m} - {D}/{0M}/{YY}"),
      Jason.encode(parsed_order)
    } do

      {
        { :ok, now },
        { :ok, body }
      } ->

        case HTTPoison.post(
          "https://delivery-center-recruitment-ap.herokuapp.com/",
          body,
          [
            { "Content-type", "application/json" },
            { "X-Sent", now }
          ]
        ) do

          { :ok, %HTTPoison.Response{ status_code: 200 } } ->

            with {:ok, %Order{} = order} <- MarketPlace.create_order(parsed_order) do
              conn
              |> put_status(:created)
              |> render("show.json", order: order)
            end

          { :ok, %HTTPoison.Response{ status_code: 400, body: error } } ->

            conn
            |> put_status(:bad_request)
            |> render("error.json", message: error)

          { :error, %HTTPoison.Error{ reason: reason } } ->

            conn
            |> put_status(:service_unavailable)
            |> render("error.json", message: reason)

          _ ->

            conn
            |> put_status(:internal_server_error)
            |> render("error.json", message: "Unexpetecd error")

        end

      { { :error, message }, _ } ->

        conn
        |> put_status(:internal_server_error)
        |> render("error.json", message: message)

      { _, { :error, message } } ->

        conn
        |> put_status(:internal_server_error)
        |> render("error.json", message: message)

    end
  end
end
