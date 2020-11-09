defmodule CarData.Schema.Fuel.FuelEconomy do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "fuel_economy" do
    field :barrels_per_year_primary, :float
    field :barrels_per_year_secondary, :float
    field :city_mpg_primary, :integer
    field :city_mpg_secondary, :integer
    field :highway_mpg_primary, :integer
    field :highway_mpg_secondary, :integer
    field :combined_mpg_primary, :integer
    field :combined_mpg_secondary, :integer
    field :annual_fuel_cost_primary, :integer
    field :annual_fuel_cost_secondary, :integer
    field :combined_power_consumption, :float
    field :fuel_economy_score, :integer
    field :epa_range_secondary, :string
    field :epa_city_range_secondary, :float
    field :epa_highway_range_secondary, :float
    field :is_guzzler, :boolean
    field :time_to_charge_120v, :float
    field :time_to_charge_240v, :float

    belongs_to :engine, CarData.Schema.Powertrain.Engine, type: :binary_id
  end
end