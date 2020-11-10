defmodule CarDataWeb.Resolvers.Vehicle do
  alias CarData.Schema.Vehicle.Vehicle

  def find_transmission(%Vehicle{id: vehicle_id}, _args, _resolution) do
    case CarData.Repo.Vehicle.find_transmission(%{vehicle_id: vehicle_id}) do
      nil -> {:error, "Transmission with Vehicle ID #{vehicle_id} not found}"}
      [transmission | _] -> {:ok, transmission}
    end
  end

  def find_transmission(_parent, %{id: transmission_id}, _resolution) do
    case CarData.Repo.Vehicle.find_transmission(%{transmission_id: transmission_id}) do
      nil -> {:error, "Transmission with ID #{transmission_id} not found}"}
      transmission -> {:ok, transmission}
    end
  end

  def find_dimensions(%Vehicle{id: vehicle_id}, _args, _resolution) do
    case CarData.Repo.Vehicle.find_dimensions(%{vehicle_id: vehicle_id}) do
      nil -> {:error, "Dimensions with Vehicle ID #{vehicle_id} not found}"}
      [dimensions | _] -> {:ok, dimensions}
    end
  end

  def find_dimensions(_parent, %{id: dimensions_id}, _resolution) do
    case CarData.Repo.Vehicle.find_dimensions(%{dimensions_id: dimensions_id}) do
      nil -> {:error, "Dimensions with ID #{dimensions_id} not found}"}
      dimensions -> {:ok, dimensions}
    end
  end

  def find_engine(%Vehicle{id: vehicle_id}, _args, _resolution) do
    case CarData.Repo.Vehicle.find_engine(%{vehicle_id: vehicle_id}) do
      nil -> {:error, "Engine with Vehicle ID #{vehicle_id} not found}"}
      [dimensions | _] -> {:ok, dimensions}
    end
  end

  def find_engine(_parent, %{id: engine_id}, _resolution) do
    case CarData.Repo.Vehicle.find_engine(%{engine_id: engine_id}) do
      nil -> {:error, "Engine with ID #{engine_id} not found}"}
      dimensions -> {:ok, dimensions}
    end
  end
end