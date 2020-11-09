defmodule CarData.Powertrain.Transmission do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transmission" do
    field :descriptor, :string
    field :type, :string
  end
end