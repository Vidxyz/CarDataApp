defmodule CarData.Schema.Vehicle.Vehicle do
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
    field :alternative_fuel_type, :string
    field :vehicle_class, :string
  end
end