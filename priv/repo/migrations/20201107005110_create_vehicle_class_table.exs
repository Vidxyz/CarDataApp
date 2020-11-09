defmodule CarData.Repo.Migrations.CreateVehicleClassTable do
  use Ecto.Migration
  alias CarData.Schema.Types.VehicleClass

  def change do
    create table(:vehicle_class) do
      add :name, :string
      add :description, :string
    end

    flush()

    CarData.Repo.insert(VehicleClass.two_seaters)
    CarData.Repo.insert(VehicleClass.mini_compact_cars)
    CarData.Repo.insert(VehicleClass.sub_compact_cars)
    CarData.Repo.insert(VehicleClass.compact_cars)
    CarData.Repo.insert(VehicleClass.midsize_cars)
    CarData.Repo.insert(VehicleClass.large_cars)
    CarData.Repo.insert(VehicleClass.small_station_wagons)
    CarData.Repo.insert(VehicleClass.midsize_station_wagons)
    CarData.Repo.insert(VehicleClass.large_cars_station_wagons)
    CarData.Repo.insert(VehicleClass.small_pickup_trucks)
    CarData.Repo.insert(VehicleClass.standard_pickup_trucks)
    CarData.Repo.insert(VehicleClass.passenger_vans)
    CarData.Repo.insert(VehicleClass.cargo_vans)
    CarData.Repo.insert(VehicleClass.minivans)
    CarData.Repo.insert(VehicleClass.suvs)
    CarData.Repo.insert(VehicleClass.small_suvs)
    CarData.Repo.insert(VehicleClass.standard_suvs)
    CarData.Repo.insert(VehicleClass.special_purpose_vehicles())

  end
end
