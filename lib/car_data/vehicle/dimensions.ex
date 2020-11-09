defmodule CarData.Vehicle.Dimensions do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "dimensions" do
    field :hatchback_luggage_volume, :integer
    field :hatchback_passenger_volume, :integer
    field :two_door_luggage_volume, :integer
    field :four_door_luggage_volume, :integer
    field :two_door_passenger_volume, :integer
    field :four_door_passenger_volume, :integer
  end
end