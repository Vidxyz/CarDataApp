defmodule CarData.Vehicle do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "vehicle" do
    field :id, Ecto.UUID
    field :make, :string
    field :model, :string
    field :year, :int
    field :fuel_type_primary, :string
    field :fuel_type_secondary, :string
    field :fuel_type, :string
    field :manufacturer_code, :string
    field :record_id, :int
    field :engine_id, Ecto.UUID
    field :transmission_id, Ecto.UUID
    field :dimensions_id, Ecto.UUID
    field :alternative_fuel_type, :string
    field :vehicle_class, :string

    has_one :engine, CarData.Engine, foreign_key: :id, refererences: :engine_id
    has_one :transmission, CarData.Transmission, foreign_key: :id, refererences: :transmission_id
    has_one :dimensions, CarData.Dimensions, foreign_key: :id, refererences: :dimensions_id
  end
end