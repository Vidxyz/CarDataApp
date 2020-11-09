defmodule CarData.FuelEmission do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "fuel_emission" do
    field :id, Ecto.UUID
    field :tailpipe_co2_primary, :float
    field :tailpipe_co2_secondary, :float
    field :gh_gas_score_primary, :int
    field :gh_gas_score_secondary, :int
  end
end