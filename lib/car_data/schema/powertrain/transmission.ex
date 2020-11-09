defmodule CarData.Schema.Powertrain.Transmission do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transmission" do
    field :descriptor, :string
    field :type, :string

    belongs_to :vehicle, CarData.Schema.Vehicle.Vehicle, type: :binary_id
  end
end