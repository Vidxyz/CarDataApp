defmodule CarDataWeb.Resolvers.Content do
  alias CarData.Repo.Vehicle

  @valid_metrics Vehicle.valid_metrics
  @valid_orders ["asc", "desc"]

  def sort_vehicles_by_metric(_parent, %{metric: metric, order: order, limit: limit, offset: offset}, _resolution) do
    case order do
      o when o in @valid_orders ->
        case metric do
          m when m in @valid_metrics -> {:ok, Vehicle.sort_vehicles_by_metric(metric, order, limit, offset)}
          _ -> {:error, "Unsupported Metric"}
        end
      _ -> {:error, "Expected order to be one of 'asc' or 'desc'"}
      end
  end

  def find_vehicles_count(_parent, %{query: search_query}, _resolution) do
    case Vehicle.find_vehicles_count(search_query) do
      nil -> {:error, "An error has occurred"}
      resulting_counts -> {:ok, Enum.sum(resulting_counts)}
    end
  end

  def find_vehicles(_parent, %{ids: ids, limit: limit, offset: offset}, _resolution) do
    {:ok, Vehicle.find_vehicles(ids, limit, offset)}
  end

  def find_vehicles(_parent, %{ids: ids, offset: offset}, _resolution) do
    {:ok, Vehicle.find_vehicles(ids, offset)}
  end

  def find_vehicles(_parent, %{query: search_query, limit: limit, offset: offset}, _resolution) do
    {:ok, Vehicle.find_vehicles(search_query, limit, offset)}
  end

  def find_vehicles(_parent, %{query: search_query, offset: offset}, _resolution) do
    {:ok, Vehicle.find_vehicles(search_query, offset)}
  end

  def find_vehicle(_parent, %{id: id}, _resolution) do
    case Vehicle.find_vehicle(id) do
      nil -> {:error, "Vehicle with ID #{id} not found}"}
      vehicle -> {:ok, vehicle}
    end
  end

  def random_vehicle(_parent, _args, _resolution) do
    case Vehicle.get_random_vehicle() do
      nil -> {:error, "An error has occurred"}
      [vehicle | tail] -> {:ok, vehicle}
    end
  end

  def get_vehicles(_parent, %{limit: limit, offset: offset}, _resolution) do
    {:ok, Vehicle.get_vehicles(limit, offset)}
  end

end