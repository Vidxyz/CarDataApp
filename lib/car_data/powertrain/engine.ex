defmodule CarData.Powertrain.Engine do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "engine" do
    field :cylinders, :float
    field :displacement, :float
    field :engine_id, :integer
    field :engine_descriptor, :string
    field :ev_motor, :string
    field :is_supercharged, :boolean
    field :is_turbocharged, :boolean
    field :fuel_economy_id, Ecto.UUID
    field :fuel_emission_id, Ecto.UUID
    field :drive_type, :string

    has_one :fuel_economy, CarData.Fuel.FuelEconomy, foreign_key: :id, references: :fuel_economy_id
    has_one :fuel_emission, CarData.Fuel.FuelEmission, foreign_key: :id, references: :fuel_emission_id
  end
end