defmodule CarData.Repo.Vehicle do
  import Ecto.Query, warn: false
  alias CarData.Repo
  alias CarData.Schema.Vehicle.Vehicle
  alias CarData.Schema.Powertrain.Transmission
  alias CarData.Schema.Powertrain.Engine
  alias CarData.Schema.Vehicle.Dimensions
  alias CarData.Schema.Fuel.FuelEconomy
  alias CarData.Schema.Fuel.FuelEmission

  @metric_mappings %{"greenhouse_gas_score_primary" => "gh_gas_score_primary"}
  @fuel_metric_to_table_mappings %{
    "gh_gas_score_primary" => FuelEmission,
    "tailpipe_co2_primary" => FuelEmission,
    "barrels_per_year_primary" => FuelEconomy,
    "city_mpg_primary" => FuelEconomy,
    "highway_mpg_primary" => FuelEconomy,
    "combined_mpg_primary" => FuelEconomy,
    "annual_fuel_cost_primary" => FuelEconomy,
    "fuel_economy_score" => FuelEconomy,
  }
  @fuel_metrics [
    "gh_gas_score_primary", "tailpipe_co2_primary", "barrels_per_year_primary", "city_mpg_primary",
    "highway_mpg_primary", "combined_mpg_primary", "annual_fuel_cost_primary", "fuel_economy_score"
  ]
  @engine_metrics ["cylinders", "displacement"]
  @dimensions_metrics [
    "hatchback_luggage_volume", "hatchback_passenger_volume", "two_door_luggage_volume",
    "four_door_luggage_volume", "two_door_passenger_volume", "four_door_passenger_volume"
  ]

  defp add_sort_criteria_for_fuel_metrics(query, field_name, table, order) do
    query
    |> join(:inner, [v, e, fe], fe in ^table, on: fe.engine_id == e.id)
    |> where([v, _e, fe], not is_nil(field(fe, ^field_name)))
    |> order_by([v, _e, fe], [{^String.to_atom(order), field(fe, ^field_name)}, asc: v.year, asc: v.make, asc: v.model])
  end

  defp sort_vehicles_by_fuel_metric(metric, order, max_elements, offset) do
    query = from v in Vehicle,
                 join: e in Engine,
                 on: v.id == e.vehicle_id,
                 limit: ^max_elements,
                 offset: ^offset

    case Map.get(@metric_mappings, metric) do
      nil ->      query |> add_sort_criteria_for_fuel_metrics(String.to_atom(metric), Map.get(@fuel_metric_to_table_mappings, metric), order)
      mapping ->  query |> add_sort_criteria_for_fuel_metrics(String.to_atom(mapping), Map.get(@fuel_metric_to_table_mappings, mapping), order)
    end
  end

  defp sort_vehicles_by_engine_metric(metric, order, max_elements, offset) do
    query = from v in Vehicle,
                 join: e in Engine,
                 on: v.id == e.vehicle_id,
                 limit: ^max_elements,
                 offset: ^offset

    query
    |> where([v, e], not is_nil(field(e, ^String.to_atom(metric))))
    |> order_by([v, e], [{^String.to_atom(order), field(e, ^String.to_atom(metric))}, asc: v.year, asc: v.make, asc: v.model])
  end

  defp sort_vehicles_by_dimensions_metric(metric, order, max_elements, offset) do
    query = from v in Vehicle,
                 join: d in Dimensions,
                 on: v.id == d.vehicle_id,
                 limit: ^max_elements,
                 offset: ^offset

    query
    |> where([v, d], not is_nil(field(d, ^String.to_atom(metric))))
    |> order_by([v, d], [{^String.to_atom(order), field(d, ^String.to_atom(metric))}, asc: v.year, asc: v.make, asc: v.model])
  end

  # todo - graceful error handling
  def sort_vehicles_by_metric(metric, order, max_elements, offset) do
    case order do
      value when value in ["asc", "desc"] ->
        case metric do
          value when value in @fuel_metrics -> sort_vehicles_by_fuel_metric(metric, order, max_elements, offset)
          value when value in @engine_metrics -> sort_vehicles_by_engine_metric(metric, order, max_elements, offset)
          value when value in @dimensions_metrics -> sort_vehicles_by_dimensions_metric(metric, order, max_elements, offset)
          _ -> {:error, "Unsupported Metric"}
        end
      _ -> {:error, "Expected order to be one of 'asc' or 'desc'"}
    end
    |> Repo.all
  end

  def find_vehicles(search_query) do
    query = from(v in Vehicle)
    search_query
    |> String.split
    |> Enum.reduce(query, fn (term, query) ->
        case Integer.parse(term) do
          {whole, _decimal} -> from v in query, where: v.year == ^whole
          :error -> from v in query, where: ilike(v.make, ^"%#{term}%") or ilike(v.model, ^"%#{term}%")
        end
      end)
    |> Repo.all
  end

  def find_vehicle(vehicle_id) do
    Repo.get(Vehicle, vehicle_id)
  end

  def find_transmission(%{vehicle_id: vehicle_id}) do
    from(t in Transmission, where: t.vehicle_id == ^vehicle_id)
    |> Repo.all
  end

  def find_transmission(%{transmission_id: transmission_id}) do
    Repo.get!(Transmission, transmission_id)
  end

  def find_dimensions(%{vehicle_id: vehicle_id}) do
    from(d in Dimensions, where: d.vehicle_id == ^vehicle_id)
    |> Repo.all
  end

  def find_dimensions(%{dimensions_id: dimensions_id}) do
    Repo.get(Dimensions, dimensions_id)
  end

  def find_engine(%{vehicle_id: vehicle_id}) do
    from(e in Engine, where: e.vehicle_id == ^vehicle_id)
    |> Repo.all
  end

  def find_engine(%{engine_id: engine_id}) do
    Repo.get!(Engine, engine_id)
  end

  def find_fuel_economy(%{engine_id: engine_id}) do
    from(fe in FuelEconomy, where: fe.engine_id == ^engine_id)
    |> Repo.all
  end

  def find_fuel_economy(%{fuel_economy_id: fuel_economy_id}) do
    Repo.get(FuelEconomy, fuel_economy_id)
  end

  def find_fuel_emission(%{engine_id: engine_id}) do
    from(fe in FuelEmission, where: fe.engine_id == ^engine_id)
    |> Repo.all
  end

  def find_fuel_emission(%{fuel_emission_id: fuel_emission_id}) do
    Repo.get(FuelEmission, fuel_emission_id)
  end
end