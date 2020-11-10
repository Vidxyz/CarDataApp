defmodule CarDataWeb.Resolvers.Content do


  def find_vehicles(_parent, %{query: search_query}, _resolution) do
    {:ok, CarData.Repo.Vehicle.find_vehicles(search_query)}
  end

  def find_vehicle(_parent, %{id: id}, _resolution) do
    case CarData.Repo.Vehicle.find_vehicle(id) do
      nil -> {:error, "Vehicle with ID #{id} not found}"}
      vehicle -> {:ok, vehicle}
    end
  end

end