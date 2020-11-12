defmodule CarDataWeb.Schema.VehicleTypes do
  use Absinthe.Schema.Notation
  alias CarDataWeb.Resolvers

  @desc "Vehicle Transmission Type"
  object :transmission do
    field :id, :id
    field :type, :string
    # todo - clean this defn
    field :transmission_descriptor, :string
  end

  @desc "Vehicle Dimensions Type"
  object :dimensions do
    field :id, :id
    field :hatchback_luggage_volume, :integer
    field :hatchback_passenger_volume, :integer
    field :two_door_passenger_volume, :integer
    field :four_door_passenger_volume, :integer
    field :two_door_luggage_volume, :integer
    field :four_door_luggage_volume, :integer
  end

  @desc "Vehicle Engine Type"
  object :engine do
    field :id, :id
    field :cylinders, :float
    field :displacement, :float
    field :engine_id, :integer
    # todo - clean this defn
    field :engine_descriptor, :string
    field :ev_motor, :string
    field :is_supercharged, :boolean
    field :is_turbocharged, :boolean
    field :drive_type, :string
    field :fuel_economy, :fuel_economy do
      resolve &Resolvers.Engine.find_fuel_economy/3
    end
    field :fuel_emission, :fuel_emission do
      resolve &Resolvers.Engine.find_fuel_emission/3
    end
  end
end