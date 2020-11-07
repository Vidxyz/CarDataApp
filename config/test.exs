use Mix.Config

# Configure your database
config :car_data, CarData.Repo,
  username: "postgres",
  password: "postgres",
  database: "car_data_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :car_data, CarDataWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
