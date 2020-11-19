defmodule CarData.Schema.Vehicle.Image do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "image" do
    field :image, :binary
    field :width, :integer
    field :height, :integer
    belongs_to :vehicle, CarData.Schema.Vehicle.Vehicle, type: :binary_id
    timestamps()
  end
end