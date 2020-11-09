defmodule CarData.FuelEconomy do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "fuel_economy" do
    field :id, Ecto.UUID
    field :barrels_per_year_primary, :float
    field :barrels_per_year_secondary, :float
    field :city_mpg_primary, :int
    field :city_mpg_secondary, :int
    field :highway_mpg_primary, :int
    field :highway_mpg_secondary, :int
    field :combined_mpg_primary, :int
    field :combined_mpg_secondary, :int
    field :annual_fuel_cost_primary, :int
    field :annual_fuel_cost_secondary, :int
    field :combined_power_consumption, :float
    field :fuel_economy_score, :int
    field :epa_range_secondary, :string
    field :epa_city_range_secondary, :float
    field :epa_highway_range_secondary, :float
    field :is_guzzler, :boolean
    field :time_to_charge_120v, :float
    field :time_to_charge_240v, :float
  end
end