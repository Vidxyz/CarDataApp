defmodule CarData.Repo.Migrations.CreateDimensionsTable do
  use Ecto.Migration

  def change do
    create table(:dimensions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :hatchback_luggage_volume, :int
      add :hatchback_passenger_volume, :int
      add :two_door_luggage_volume, :int
      add :four_door_luggage_volume, :int
      add :two_door_passenger_volume, :int
      add :four_door_passenger_volume, :int
    end
  end
end
