defmodule CarData.Repo.Migrations.CreateVehicleTable do
  use Ecto.Migration
  alias CarData.Schema.Types.AlternativeFuelType

  def change do
    create table(:vehicle, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :make, :string
      add :model, :string
      add :year, :int
      add :fuel_type_primary, :string
      add :fuel_type_secondary, :string
      add :fuel_type, :string
      add :manufacturer_code, :string
      add :record_id, :int
      add :alternative_fuel_type, :string
      add :vehicle_class, :string
    end

    create constraint("vehicle", :alternative_fuel_type_must_be_recognized, check: """
    alternative_fuel_type in ('#{AlternativeFuelType.bcng.name}', '#{AlternativeFuelType.blpg.name}',
    '#{AlternativeFuelType.cng.name}', '#{AlternativeFuelType.diesel.name}',
    '#{AlternativeFuelType.ev.name}', '#{AlternativeFuelType.ffv.name}', '#{AlternativeFuelType.hybrid.name}',
    '#{AlternativeFuelType.plug_in_hybrid.name}')
    """)
  end
end
