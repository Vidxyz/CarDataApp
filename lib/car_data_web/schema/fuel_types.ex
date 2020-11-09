defmodule CarDataWeb.Schema.FuelTypes do
  use Absinthe.Schema.Notation

  @desc "Engine Fuel Economy Type"
  object :fuel_economy do
    field :id, :id
    field :barrels_per_year_primary, :float
    field :barrels_per_year_secondary, :float
    field :city_mpg_primary, :integer
    field :city_mpg_secondary, :integer
    field :highway_mpg_secondary, :integer
    field :highway_mpg_secondary, :integer
    field :combined_mpg_secondary, :integer
    field :combined_mpg_secondary, :integer
    field :annual_fuel_cost_primary, :integer
    field :annual_fuel_cost_secondary, :integer
    field :combined_power_consumption, :float
    field :fuel_economy_score, :integer
    field :epa_range_secondary, :string
    field :epa_city_range_secondary, :string
    field :epa_highway_range_secondary, :string
    field :is_guzzler, :boolean
    field :time_to_charge_120v, :float
    field :time_to_charge_240v, :float
  end

  @desc "Engine Fuel Emission Type"
  object :fuel_emission do
    field :id, :id
    field :tailpipe_co2_primary, :float
    field :tailpipe_co2_seconary, :float
    field :gh_gas_score_primary, :integer
    field :gh_gas_score_secondary, :integer
  end
end
