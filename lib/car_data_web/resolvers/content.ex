defmodule CarDataWeb.Resolvers.Content do
  alias CarData.Schema.Vehicle.Vehicle
  alias CarData.Schema.Powertrain.Engine

  def find_vehicle(_parent, %{id: id}, _resolution) do
    case CarData.Repo.Vehicle.find_vehicle!(id) do
      nil -> {:error, "Vehicle with ID #{id} not found}"}
      vehicle -> {:ok, vehicle}
    end
  end

  def find_transmission(%Vehicle{id: vehicle_id}, _args, _resolution) do
    case CarData.Repo.Vehicle.find_transmission!(%{vehicle_id: vehicle_id}) do
      nil -> {:error, "Transmission with Vehicle ID #{vehicle_id} not found}"}
      [transmission | _] -> {:ok, transmission}
    end
  end

  def find_transmission(_parent, %{id: transmission_id}, _resolution) do
    case CarData.Repo.Vehicle.find_transmission!(%{transmission_id: transmission_id}) do
      nil -> {:error, "Transmission with ID #{transmission_id} not found}"}
      transmission -> {:ok, transmission}
    end
  end

  def find_dimensions(%Vehicle{id: vehicle_id}, _args, _resolution) do
    case CarData.Repo.Vehicle.find_dimensions!(%{vehicle_id: vehicle_id}) do
      nil -> {:error, "Dimensions with Vehicle ID #{vehicle_id} not found}"}
      [dimensions | _] -> {:ok, dimensions}
    end
  end

  def find_dimensions(_parent, %{id: dimensions_id}, _resolution) do
    case CarData.Repo.Vehicle.find_dimensions!(%{dimensions_id: dimensions_id}) do
      nil -> {:error, "Dimensions with ID #{dimensions_id} not found}"}
      dimensions -> {:ok, dimensions}
    end
  end

  def find_engine(%Vehicle{id: vehicle_id}, _args, _resolution) do
    case CarData.Repo.Vehicle.find_engine!(%{vehicle_id: vehicle_id}) do
      nil -> {:error, "Engine with Vehicle ID #{vehicle_id} not found}"}
      [dimensions | _] -> {:ok, dimensions}
    end
  end

  def find_engine(_parent, %{id: engine_id}, _resolution) do
    case CarData.Repo.Vehicle.find_engine!(%{engine_id: engine_id}) do
      nil -> {:error, "Engine with ID #{engine_id} not found}"}
      dimensions -> {:ok, dimensions}
    end
  end

  def find_fuel_economy(%Engine{id: engine_id}, _args, _resolution) do
    case CarData.Repo.Vehicle.find_fuel_economy!(%{engine_id: engine_id}) do
      nil -> {:error, "Fuel Economy for Engine with ID #{engine_id} not found}"}
      [fuel_economy | _] -> {:ok, fuel_economy}
    end
  end

  def find_fuel_economy(_parent, %{id: fuel_economy_id}, _resolution) do
    case CarData.Repo.Vehicle.find_fuel_economy!(%{fuel_economy_id: fuel_economy_id}) do
      nil -> {:error, "Fuel Economy with ID #{fuel_economy_id} not found}"}
      fuel_economy -> {:ok, fuel_economy}
    end
  end

  def find_fuel_emission(%Engine{id: engine_id}, _args, _resolution) do
    case CarData.Repo.Vehicle.find_fuel_emission!(%{engine_id: engine_id}) do
      nil -> {:error, "Fuel Emission for Engine with ID #{engine_id} not found}"}
      [fuel_emission | _] -> {:ok, fuel_emission}
    end
  end

  def find_fuel_emission(_parent, %{id: fuel_emission_id}, _resolution) do
    case CarData.Repo.Vehicle.find_fuel_emission!(%{fuel_emission_id: fuel_emission_id}) do
      nil -> {:error, "Fuel Emission for Engine with ID #{fuel_emission_id} not found}"}
      fuel_emission -> {:ok, fuel_emission}
    end
  end

end