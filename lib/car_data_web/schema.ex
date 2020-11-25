defmodule CarDataWeb.Schema do
  use Absinthe.Schema
  import_types Absinthe.Type.Custom
  import_types CarDataWeb.Schema.ContentTypes
  import_types CarDataWeb.Schema.VehicleTypes
  import_types CarDataWeb.Schema.EngineTypes
  import_types CarDataWeb.Schema.AttributeTypes

  alias CarDataWeb.Resolvers

  query do

    @desc "Fetch all distinct attribute names"
    field :attribute_names, list_of(:string) do
      resolve &Resolvers.Attribute.get_distinct_attribute_names/3
    end

    @desc "Fetch all distinct attribute values"
    field :attribute_values, :attribute_values do
      arg :attributes, list_of(:string), default_value: []
      resolve &Resolvers.Attribute.get_distinct_attribute_values/3
    end

    @desc "List vehicles ordered by chosen metric"
    field :sort, list_of(:vehicle) do
      arg :metric, non_null(:string)
      arg :order, :string, default_value: "desc"
      arg :limit, :integer, default_value: 10
      arg :offset, :integer, default_value: 0
      resolve &Resolvers.Content.sort_vehicles_by_metric/3
    end

    @desc "List vehicles by search string"
    field :search, list_of(:vehicle) do
      arg :query, non_null(:string)
      arg :limit, :integer
      resolve &Resolvers.Content.find_vehicles/3
    end

    @desc "Get all vehicles"
    field :vehicles, list_of(:vehicle) do
      arg :limit, :integer, default_value: 50
      arg :offset, :integer, default_value: 0
      resolve &Resolvers.Content.get_vehicles/3
    end

    @desc "Get Vehicle By Id"
    field :vehicle, :vehicle do
      arg :id, non_null(:id)
      resolve &Resolvers.Content.find_vehicle/3
    end

    @desc "Get Transmission by Id"
    field :transmission, :transmission do
      arg :id, non_null(:id)
      resolve &Resolvers.Vehicle.find_transmission/3
    end

    @desc "Get Dimensions by Id"
    field :dimensions, :dimensions do
      arg :id, non_null(:id)
      resolve &Resolvers.Vehicle.find_dimensions/3
    end

    @desc "Get Engine by Id"
    field :engine, :engine do
      arg :id, non_null(:id)
      resolve &Resolvers.Vehicle.find_engine/3
    end

    @desc "Get Fuel Economy by Id"
    field :fuel_economy, :fuel_economy do
      arg :id, non_null(:id)
      resolve &Resolvers.Engine.find_fuel_economy/3
    end

    @desc "Get Fuel Emission by Id"
    field :fuel_emission, :fuel_emission do
      arg :id, non_null(:id)
      resolve &Resolvers.Engine.find_fuel_emission/3
    end

  end

end