defmodule CarData.Repo.Migrations.CreateFuelEconomyTable do
  use Ecto.Migration

  def change do
    create table(:fuel_economy, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :barrels_per_year_primary, :float
      add :barrels_per_year_secondary, :float
      add :city_mpg_primary, :int
      add :city_mpg_secondary, :int
      add :highway_mpg_primary, :int
      add :highway_mpg_secondary, :int
      add :combined_mpg_primary, :int
      add :combined_mpg_secondary, :int
      add :annual_fuel_cost_primary, :int
      add :annual_fuel_cost_secondary, :int
      add :combined_power_consumption, :float
      add :fuel_economy_score, :int
      add :epa_range_secondary, :string
      add :epa_city_range_secondary, :float
      add :epa_highway_range_secondary, :float
      add :is_guzzler, :boolean
      add :time_to_charge_120v, :float
      add :time_to_charge_240v, :float
    end
  end
end
