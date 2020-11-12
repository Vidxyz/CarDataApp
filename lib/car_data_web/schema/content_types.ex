defmodule CarDataWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation
  alias CarDataWeb.Resolvers

  object :vehicle do
    field :id, :id
    field :make, :string
    field :model, :string
    field :year, :integer
    field :fuel_type_primary, :string, name: "primary_fuel"
    field :fuel_type_secondary, :string, name: "alternate_fuel"
    field :fuel_type, :string
    field :manufacturer_code, :string
    field :record_id, :integer
    field :engine, :engine do
      resolve &Resolvers.Vehicle.find_engine/3
    end
    field :transmission, :transmission do
      resolve &Resolvers.Vehicle.find_transmission/3
    end
    field :dimensions, :dimensions do
      resolve &Resolvers.Vehicle.find_dimensions/3
    end
    field :alternate_fuel_type, :string
    field :vehicle_class, :string
  end
end