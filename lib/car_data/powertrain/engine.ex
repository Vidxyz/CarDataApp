defmodule CarData.Engine do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "engine" do
    field :id, Ecto.UUID
    field :cylinders, :float
    field :displacement, :float
    field :engine_id, :int
    field :engine_descriptor, :string
    field :ev_motor, :string
    field :is_supercharged, :boolean
    field :is_turbocharged, :boolean
    field :fuel_economy_id, Ecto.UUID
    field :fuel_emission_id, Ecto.UUID
    field :drive_type, :string

    has_one :fuel_economy, CarData.FuelEconomy, foreign_key: :id, refererences: :fuel_economy_id
    has_one :fuel_emission, CarData.FuelEmission, foreign_key: :id, refererences: :fuel_emission_id
  end
end