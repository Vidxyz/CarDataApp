defmodule CarData.Vehicle.Vehicle do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "vehicle" do
    field :make, :string
    field :model, :string
    field :year, :integer
    field :fuel_type_primary, :string
    field :fuel_type_secondary, :string
    field :fuel_type, :string
    field :manufacturer_code, :string
    field :record_id, :integer
    field :engine_id, Ecto.UUID
    field :transmission_id, Ecto.UUID
    field :dimensions_id, Ecto.UUID
    field :alternative_fuel_type, :string
    field :vehicle_class, :string

    has_one :engine, CarData.Powertrain.Engine, foreign_key: :id, references: :engine_id
    has_one :transmission, CarData.Powertrain.Transmission, foreign_key: :id, references: :transmission_id
    has_one :dimensions, CarData.Vehicle.Dimensions, foreign_key: :id, references: :dimensions_id
  end
end