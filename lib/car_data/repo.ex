defmodule CarData.Repo do
  use Ecto.Repo,
    otp_app: :car_data,
    adapter: Ecto.Adapters.Postgres
end