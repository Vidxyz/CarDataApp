defmodule CarDataWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation
  alias CarDataWeb.Resolvers

  object :vehicle do
    field :id, :id
    field :make, :string
    field :model, :string
    field :year, :integer
    field :primary_fuel, :string
    field :alternate_fuel, :string
    field :fuel_type, :string
    field :manufacturer_code, :string
    field :vehicle_record, :integer
    field :engine, :engine do
      resolve &Resolvers.Content.find_engine/3
    end
    field :transmission, :transmission do
      resolve &Resolvers.Content.find_transmission/3
    end
    field :dimensions, :dimensions do
      resolve &Resolvers.Content.find_dimensions/3
    end
    field :alternate_fuel_type, :string
    field :vehicle_class, :string
  end
end