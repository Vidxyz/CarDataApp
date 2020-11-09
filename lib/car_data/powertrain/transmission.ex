defmodule CarData.Transmission do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transmission" do
    field :id, Ecto.UUID
    field :descriptor, :string
    field :type, :string
  end
end