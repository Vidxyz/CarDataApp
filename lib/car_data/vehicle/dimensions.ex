defmodule CarData.Dimensions do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "dimensions" do
    field :id, Ecto.UUID
    field :hatchback_luggage_volume, :int
    field :hatchback_passenger_volume, :int
    field :two_door_luggage_volume, :int
    field :four_door_luggage_volume, :int
    field :two_door_passenger_volume, :int
    field :four_door_passenger_volume, :int
  end
end