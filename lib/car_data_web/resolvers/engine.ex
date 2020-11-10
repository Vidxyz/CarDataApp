defmodule CarDataWeb.Resolvers.Engine do
  alias CarData.Schema.Powertrain.Engine

  def find_fuel_economy(%Engine{id: engine_id}, _args, _resolution) do
    case CarData.Repo.Vehicle.find_fuel_economy(%{engine_id: engine_id}) do
      nil -> {:error, "Fuel Economy for Engine with ID #{engine_id} not found}"}
      [fuel_economy | _] -> {:ok, fuel_economy}
    end
  end

  def find_fuel_economy(_parent, %{id: fuel_economy_id}, _resolution) do
    case CarData.Repo.Vehicle.find_fuel_economy(%{fuel_economy_id: fuel_economy_id}) do
      nil -> {:error, "Fuel Economy with ID #{fuel_economy_id} not found}"}
      fuel_economy -> {:ok, fuel_economy}
    end
  end

  def find_fuel_emission(%Engine{id: engine_id}, _args, _resolution) do
    case CarData.Repo.Vehicle.find_fuel_emission(%{engine_id: engine_id}) do
      nil -> {:error, "Fuel Emission for Engine with ID #{engine_id} not found}"}
      [fuel_emission | _] -> {:ok, fuel_emission}
    end
  end

  def find_fuel_emission(_parent, %{id: fuel_emission_id}, _resolution) do
    case CarData.Repo.Vehicle.find_fuel_emission(%{fuel_emission_id: fuel_emission_id}) do
      nil -> {:error, "Fuel Emission for Engine with ID #{fuel_emission_id} not found}"}
      fuel_emission -> {:ok, fuel_emission}
    end
  end

end