defmodule CarData.Repo.Migrations.CreateFuelEmissionTable do
  use Ecto.Migration

  def change do
    create table(:fuel_emission, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :tailpipe_co2_primary, :float
      add :tailpipe_co2_secondary, :float
      add :gh_gas_score_primary, :int
      add :gh_gas_score_secondary, :int
    end
  end
end
