defmodule CarData.Schema.Fuel.FuelEmission do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "fuel_emission" do
    field :tailpipe_co2_primary, :float
    field :tailpipe_co2_secondary, :float
    field :gh_gas_score_primary, :integer
    field :gh_gas_score_secondary, :integer

    belongs_to :engine, CarData.Schema.Powertrain.Engine, type: :binary_id
  end
end