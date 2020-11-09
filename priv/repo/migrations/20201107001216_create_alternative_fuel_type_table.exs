defmodule CarData.Repo.Migrations.CreateAlternativeFuelTypeTable do
  use Ecto.Migration
  alias CarData.Schema.Types.AlternativeFuelType

  def change do
    create table(:alternative_fuel_type) do
      add :name, :string
      add :description, :string
    end

    flush()

    CarData.Repo.insert(AlternativeFuelType.bcng)
    CarData.Repo.insert(AlternativeFuelType.blpg)
    CarData.Repo.insert(AlternativeFuelType.cng)
    CarData.Repo.insert(AlternativeFuelType.diesel)
    CarData.Repo.insert(AlternativeFuelType.ev)
    CarData.Repo.insert(AlternativeFuelType.ffv)
    CarData.Repo.insert(AlternativeFuelType.hybrid())
    CarData.Repo.insert(AlternativeFuelType.plug_in_hybrid())

  end
end
