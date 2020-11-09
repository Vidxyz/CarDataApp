defmodule CarDataWeb.Schema do
  use Absinthe.Schema
  import_types Absinthe.Type.Custom
  import_types CarDataWeb.Schema.ContentTypes
  import_types CarDataWeb.Schema.VehicleTypes
  import_types CarDataWeb.Schema.FuelTypes

  alias CarDataWeb.Resolvers

  query do

    @desc "Get Vehicle By Id"
    field :vehicle, :vehicle do
      arg :id, non_null(:id)
      resolve &Resolvers.Content.find_vehicle/3
    end

    @desc "Get Transmission by Id"
    field :transmission, :transmission do
      arg :id, non_null(:id)
      resolve &Resolvers.Content.find_transmission/3
    end

    @desc "Get Dimensions by Id"
    field :dimensions, :dimensions do
      arg :id, non_null(:id)
      resolve &Resolvers.Content.find_dimensions/3
    end

    @desc "Get Engine by Id"
    field :engine, :engine do
      arg :id, non_null(:id)
      resolve &Resolvers.Content.find_engine/3
    end

    @desc "Get Fuel Economy by Id"
    field :fuel_economy, :fuel_economy do
      arg :id, non_null(:id)
      resolve &Resolvers.Content.find_fuel_economy/3
    end

    @desc "Get Fuel Emission by Id"
    field :fuel_emission, :fuel_emission do
      arg :id, non_null(:id)
      resolve &Resolvers.Content.find_fuel_emission/3
    end

  end

end