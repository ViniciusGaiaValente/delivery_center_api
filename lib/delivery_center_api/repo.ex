defmodule DeliveryCenterApi.Repo do
  use Ecto.Repo,
    otp_app: :delivery_center_api,
    adapter: Ecto.Adapters.Postgres
end
