defmodule CarDataWeb.Schema.AttributeTypes do
  use Absinthe.Schema.Notation
  alias CarDataWeb.Resolvers

  @desc "Attribute Values Type"
  object :attribute_values do
    field :make, list_of(:string)
    field :model, list_of(:string)
    field :year, list_of(:string)
    field :fuel_type_primary, list_of(:string)
    field :fuel_type_secondary, list_of(:string)
    field :fuel_type, list_of(:string)
    field :manufacturer_code, list_of(:string)
    field :record_id, list_of(:string)
    field :alternative_fuel_type, list_of(:string)
    field :vehicle_class, list_of(:string)
    field :hatchback_luggage_volume, list_of(:string)
    field :hatchback_passenger_volume, list_of(:string)
    field :two_door_luggage_volume, list_of(:string)
    field :four_door_luggage_volume, list_of(:string)
    field :two_door_passenger_volume, list_of(:string)
    field :four_door_passenger_volume, list_of(:string)
    field :vehicle_id, list_of(:string)
    field :transmission_descriptor, list_of(:string)
    field :type, list_of(:string)
    field :vehicle_id, list_of(:string)
    field :cylinders, list_of(:string)
    field :displacement, list_of(:string)
    field :engine_id, list_of(:string)
    field :engine_descriptor, list_of(:string)
    field :ev_motor, list_of(:string)
    field :is_supercharged, list_of(:string)
    field :is_turbocharged, list_of(:string)
    field :drive_type, list_of(:string)
    field :vehicle_id, list_of(:string)
    field :barrels_per_year_primary, list_of(:string)
    field :barrels_per_year_secondary, list_of(:string)
    field :city_mpg_primary, list_of(:string)
    field :city_mpg_secondary, list_of(:string)
    field :highway_mpg_primary, list_of(:string)
    field :highway_mpg_secondary, list_of(:string)
    field :combined_mpg_primary, list_of(:string)
    field :combined_mpg_secondary, list_of(:string)
    field :annual_fuel_cost_primary, list_of(:string)
    field :annual_fuel_cost_secondary, list_of(:string)
    field :combined_power_consumption, list_of(:string)
    field :fuel_economy_score, list_of(:string)
    field :epa_range_secondary, list_of(:string)
    field :epa_city_range_secondary, list_of(:string)
    field :epa_highway_range_secondary, list_of(:string)
    field :is_guzzler, list_of(:string)
    field :time_to_charge_120v, list_of(:string)
    field :time_to_charge_240v, list_of(:string)
    field :engine_id, list_of(:string)
    field :tailpipe_co2_primary, list_of(:string)
    field :tailpipe_co2_secondary, list_of(:string)
    field :gh_gas_score_primary, list_of(:string)
    field :gh_gas_score_secondary, list_of(:string)
    field :engine_id, list_of(:string)
  end
end