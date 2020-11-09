defmodule CarData.Repo.Vehicle do
  import Ecto.Query, warn: false
  alias CarData.Repo
  alias CarData.Schema.Vehicle.Vehicle
  alias CarData.Schema.Powertrain.Transmission
  alias CarData.Schema.Powertrain.Engine
  alias CarData.Schema.Vehicle.Dimensions
  alias CarData.Schema.Fuel.FuelEconomy
  alias CarData.Schema.Fuel.FuelEmission

  def find_vehicle!(vehicle_id) do
    Repo.get!(Vehicle, vehicle_id)
  end

  def find_transmission!(%{vehicle_id: vehicle_id}) do
    from(t in Transmission, where: t.vehicle_id == ^vehicle_id)
    |> Repo.all
  end

  def find_transmission!(%{transmission_id: transmission_id}) do
    Repo.get!(Transmission, transmission_id)
  end

  def find_dimensions!(%{vehicle_id: vehicle_id}) do
    from(d in Dimensions, where: d.vehicle_id == ^vehicle_id)
    |> Repo.all
  end

  def find_dimensions!(%{dimensions_id: dimensions_id}) do
    Repo.get!(Dimensions, dimensions_id)
  end

  def find_engine!(%{vehicle_id: vehicle_id}) do
    from(e in Engine, where: e.vehicle_id == ^vehicle_id)
    |> Repo.all
  end

  def find_engine!(%{engine_id: engine_id}) do
    Repo.get!(Engine, engine_id)
  end

  def find_fuel_economy!(%{engine_id: engine_id}) do
    from(fe in FuelEconomy, where: fe.engine_id == ^engine_id)
    |> Repo.all
  end

  def find_fuel_economy!(%{fuel_economy_id: fuel_economy_id}) do
    Repo.get!(FuelEconomy, fuel_economy_id)
  end

  def find_fuel_emission!(%{engine_id: engine_id}) do
    from(fe in FuelEmission, where: fe.engine_id == ^engine_id)
    |> Repo.all
  end

  def find_fuel_emission!(%{fuel_emission_id: fuel_emission_id}) do
    Repo.get!(FuelEmission, fuel_emission_id)
  end
end