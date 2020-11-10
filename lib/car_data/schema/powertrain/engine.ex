defmodule CarData.Schema.Powertrain.Engine do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "engine" do
    field :cylinders, :float
    field :displacement, :float
    field :engine_id, :integer
    # https://www.fueleconomy.gov/feg/findacarhelp.shtml#trany
    field :engine_descriptor, :string
    field :ev_motor, :string
    field :is_supercharged, :boolean
    field :is_turbocharged, :boolean
    field :drive_type, :string

    belongs_to :vehicle, CarData.Schema.Vehicle.Vehicle, type: :binary_id
  end
end