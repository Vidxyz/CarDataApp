defmodule CarData.Repo.Vehicle do
  import Ecto.Query, warn: false
  alias CarData.Repo
  alias CarData.Schema.Vehicle.Vehicle
  alias CarData.Schema.Vehicle.Image
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

  def valid_metrics() do @fuel_metrics ++ @engine_metrics ++ @dimensions_metrics end

  defp add_sort_criteria_for_fuel_metrics(query, field_name, table, order) do
    query
    |> join(:inner, [v, e, fe], fe in ^table, on: fe.engine_id == e.id)
    |> where([v, _e, fe], not is_nil(field(fe, ^field_name)))
    |> order_by([v, _e, fe], [{^String.to_atom(order), field(fe, ^field_name)}, desc: v.year, asc: v.make, asc: v.model])
  end

  defp sort_vehicles_by_fuel_metric(metric, order, max_elements, offset) do
    query = from v in Vehicle,
                 join: e in Engine,
                 on: v.id == e.vehicle_id,
                 limit: ^max_elements,
                 offset: ^offset

    case Map.get(@metric_mappings, metric) do
      nil     ->  query |> add_sort_criteria_for_fuel_metrics(String.to_atom(metric), Map.get(@fuel_metric_to_table_mappings, metric), order)
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
    |> order_by([v, e], [{^String.to_atom(order), field(e, ^String.to_atom(metric))}, desc: v.year, asc: v.make, asc: v.model])
  end

  # Only returns non-zero results for chosen metric
  defp sort_vehicles_by_dimensions_metric(metric, order, max_elements, offset) do
    query = from v in Vehicle,
                 join: d in Dimensions,
                 on: v.id == d.vehicle_id,
                 limit: ^max_elements,
                 offset: ^offset

    query
    |> where([v, d], not is_nil(field(d, ^String.to_atom(metric))))
    |> where([v, d], (field(d, ^String.to_atom(metric))) > 0)
    |> order_by([v, d], [{^String.to_atom(order), field(d, ^String.to_atom(metric))}, desc: v.year, asc: v.make, asc: v.model])
  end

  def sort_vehicles_by_metric(metric, order, max_elements, offset) do
    case metric do
      value when value in @fuel_metrics -> sort_vehicles_by_fuel_metric(metric, order, max_elements, offset)
      value when value in @engine_metrics -> sort_vehicles_by_engine_metric(metric, order, max_elements, offset)
      value when value in @dimensions_metrics -> sort_vehicles_by_dimensions_metric(metric, order, max_elements, offset)
    end
    |> Repo.all
  end

  defp find_vehicles_by_search_query(search_query) do
    search_terms = String.split(search_query)
    with_query = from v in Vehicle,
                      select: %{
                        term: fragment("concat(?, ' ', ?, ' ', ?)", v.make, v.model, v.year),
                        make: v.make,
                        model: v.model,
                        year: v.year,
                        id: v.id
                      }
    main_query = with_cte("search_fields", "search_fields", as: ^with_query)
                 |> select([v], v.id)
                 |> where([v], ilike(v.term, ^"#{Enum.map(search_terms, fn term -> "%#{term}%" end)}"))

    from v in Vehicle,
         where: v.id in subquery(main_query),
         order_by: [desc: v.year, asc: v.make, asc: v.model]
  end

  defp find_vehicles_by_ids_query(vehicle_ids) do
    from v in Vehicle,
    where: v.id in ^vehicle_ids,
    order_by: [asc: v.id]
  end

  def find_vehicles([], offset) do
    []
  end

  def find_vehicles([], max_elements, offset)  do
    []
  end

  def find_vehicles(ids = [h | t], offset) do
    find_vehicles_by_ids_query(ids)
    |> offset(^offset)
    |> Repo.all
  end

  def find_vehicles(ids = [h | t], max_elements, offset) do
    find_vehicles_by_ids_query(ids)
    |> limit(^max_elements)
    |> offset(^offset)
    |> Repo.all
  end

  def find_vehicles_count(search_query) do
    find_vehicles_by_search_query(search_query)
    |> group_by([c], [c.year, c.make, c.model])
    |> select([c], count(c.id))
    |> Repo.all
  end

  def find_vehicles(search_query, offset) do
    find_vehicles_by_search_query(search_query)
    |> offset(^offset)
    |> Repo.all
  end

  def find_vehicles(search_query, max_elements, offset) do
    find_vehicles_by_search_query(search_query)
    |> limit(^max_elements)
    |> offset(^offset)
    |> Repo.all
  end

  def find_vehicles_v1(search_query) do
    query = from(v in Vehicle)
    search_query
    |> String.split
    |> Enum.reduce(query, fn (term, query) ->
        case Integer.parse(term) do
          {whole, _decimal} -> from v in query, where: v.year == ^whole
          :error -> from v in query, where: ilike(v.make, ^"%#{term}%") or ilike(v.model, ^"%#{term}%")
        end
      end)
    |> order_by([v], [desc: v.year, asc: v.make, asc: v.model])
    |> Repo.all
  end

  def get_random_vehicle() do
    query = from v in Vehicle,
      order_by: fragment("RANDOM()"),
      limit: 1
    Repo.all(query)
  end

  def find_vehicle(vehicle_id) do
    Repo.get(Vehicle, vehicle_id)
  end

  def get_vehicles(max_elements, offset) do
    query = from v in Vehicle,
         limit: ^max_elements,
         offset: ^offset,
         order_by: [asc: v.make, asc: v.model, desc: v.year]
    query |> Repo.all
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

  def get_distinct_attribute_names do
    (Vehicle.__schema__(:fields) |> to_strings) ++
    (Dimensions.__schema__(:fields) |> to_strings) ++
    (Transmission.__schema__(:fields) |> to_strings) ++
    (Engine.__schema__(:fields) |> to_strings) ++
    (FuelEconomy.__schema__(:fields) |> to_strings) ++
    (FuelEmission.__schema__(:fields) |> to_strings)
  end

  defp to_strings(list) do
    Enum.map(list, fn f -> Atom.to_string(f) end)
  end

  def get_distinct_attribute_values(selected_attributes) do
    attribute_names = get_distinct_attribute_names()
                      |> Enum.filter(fn item -> item not in ["id", "vehicle_id", "engine_id"] end)
                      |> Enum.filter(fn item -> item in selected_attributes end)
                      |> Enum.map(fn item -> String.to_atom(item) end)
    get_distinct_attribute_values_for_chosen_attribute_names(attribute_names)
  end

  def get_distinct_attribute_values do
    attribute_names = get_distinct_attribute_names()
                      |> Enum.filter(fn item -> item not in ["id", "vehicle_id", "engine_id"] end)
                      |> Enum.map(fn item -> String.to_atom(item) end)
    get_distinct_attribute_values_for_chosen_attribute_names(attribute_names)
  end

  defp get_distinct_attribute_values_for_chosen_attribute_names(attribute_names) do
    total_dataset =  Repo.all(get_all_attributes())
    attribute_values = Enum.map(attribute_names,
      fn attribute_name -> total_dataset
        |> Enum.map(fn row -> row[attribute_name] end)
        |> Enum.uniq
        |> Enum.sort
      end)
    Enum.zip(attribute_names, attribute_values) |> Enum.into(%{})
  end

  defp get_all_attributes do
    from v in Vehicle,
     join: e in Engine, on: e.vehicle_id == v.id,
     join: t in Transmission, on: t.vehicle_id == v.id,
     join: d in Dimensions, on: d.vehicle_id == v.id,
     join: fe in FuelEconomy, on: fe.engine_id == e.id,
     join: fue in FuelEmission, on: fue.engine_id == e.id,
     select: %{
       id: v.id,
       make: v.make,
       model: v.model,
       year: v.year,
       fuel_type_primary: v.fuel_type_primary,
       fuel_type_secondary: v.fuel_type_secondary,
       fuel_type: v.fuel_type,
       manufacturer_code: v.manufacturer_code,
       record_id: v.record_id,
       alternative_fuel_type: v.alternative_fuel_type,
       vehicle_class: v.vehicle_class,
       hatchback_luggage_volume: d.hatchback_luggage_volume,
       hatchback_passenger_volume: d.hatchback_passenger_volume,
       two_door_luggage_volume: d.two_door_luggage_volume,
       four_door_luggage_volume: d.four_door_luggage_volume,
       two_door_passenger_volume: d.two_door_passenger_volume,
       four_door_passenger_volume: d.four_door_passenger_volume,
       transmission_descriptor: t.transmission_descriptor,
       type: t.type,
       cylinders: e.cylinders,
       displacement: e.displacement,
       engine_id: e.engine_id,
       engine_descriptor: e.engine_descriptor,
       ev_motor: e.ev_motor,
       is_supercharged: e.is_supercharged,
       is_turbocharged: e.is_turbocharged,
       drive_type: e.drive_type,
       barrels_per_year_primary: fe.barrels_per_year_primary,
       barrels_per_year_secondary: fe.barrels_per_year_secondary,
       city_mpg_primary: fe.city_mpg_primary,
       city_mpg_secondary: fe.city_mpg_secondary,
       highway_mpg_primary: fe.highway_mpg_primary,
       highway_mpg_secondary: fe.highway_mpg_secondary,
       combined_mpg_primary: fe.combined_mpg_primary,
       combined_mpg_secondary: fe.combined_mpg_secondary,
       annual_fuel_cost_primary: fe.annual_fuel_cost_primary,
       annual_fuel_cost_secondary: fe.annual_fuel_cost_secondary,
       combined_power_consumption: fe.combined_power_consumption,
       fuel_economy_score: fe.fuel_economy_score,
       epa_range_secondary: fe.epa_range_secondary,
       epa_city_range_secondary: fe.epa_city_range_secondary,
       epa_highway_range_secondary: fe.epa_highway_range_secondary,
       is_guzzler: fe.is_guzzler,
       time_to_charge_120v: fe.time_to_charge_120v,
       time_to_charge_240v: fe.time_to_charge_240v,
       tailpipe_co2_primary: fue.tailpipe_co2_primary,
       tailpipe_co2_secondary: fue.tailpipe_co2_secondary,
       gh_gas_score_primary: fue.gh_gas_score_primary,
       gh_gas_score_secondary: fue.gh_gas_score_secondary
     }
  end

  def find_vehicle_image(vehicle_id) do
    query = from i in Image, where: i.vehicle_id == ^vehicle_id
    {:ok, Repo.all(query)}
  end

  def find_vehicles_count_by_attributes(args, metric, order) do
    build_attribute_search_result_count_query(args)
    |> order_by([c], [{^String.to_atom(order), field(c, ^String.to_atom(metric))}])
    |> where([c], not is_nil(field(c, ^String.to_atom(metric))))
    |> group_by([c], [field(c, ^String.to_atom(metric))])
    |> select([c], count())
    |> Repo.all
  end

  def find_vehicles_count_by_attributes(args) do
    build_attribute_search_result_count_query(args)
    |> select([c], count())
    |> Repo.one
  end

  defp build_attribute_search_result_count_query(args) do
    base_query = get_all_attributes()
    the_query = with_cte("all_fields", "all_fields", as: ^base_query)

    args
    |> Enum.filter(fn {attribute_name, attribute_values} -> !Enum.empty?(attribute_values) end)
    |> Enum.reduce(the_query, fn ({attribute_name, attribute_values}, acc) ->
      where(acc, [a], field(a, ^attribute_name) in ^attribute_values) end)
  end


  def find_vehicles_by_attributes(args, max_elements, offset, metric, order) do
    build_attribute_search_query(args, max_elements, offset)
    |> order_by([c], [{^String.to_atom(order), field(c, ^String.to_atom(metric))}])
    |> where([c], not is_nil(field(c, ^String.to_atom(metric))))
    |> map_and_return_result
  end

  def find_vehicles_by_attributes(args, max_elements, offset) do
    build_attribute_search_query(args, max_elements, offset)
    |> map_and_return_result
  end

  defp build_attribute_search_query(args, max_elements, offset) do
    base_query = get_all_attributes()
    the_query = with_cte("all_fields", "all_fields", as: ^base_query)

    args
    |> Enum.filter(fn {attribute_name, attribute_values} -> !Enum.empty?(attribute_values) end)
    |> Enum.reduce(the_query, fn ({attribute_name, attribute_values}, acc) ->
      where(acc, [a], field(a, ^attribute_name) in ^attribute_values) end)
    |> select([c], %Vehicle{
      id: c.id, make: c.make, model: c.model,
      year: c.year, fuel_type_primary: c.fuel_type_primary,
      fuel_type_secondary: c.fuel_type_secondary, fuel_type: c.fuel_type,
      manufacturer_code: c.manufacturer_code, record_id: c.record_id,
      alternative_fuel_type: c.alternative_fuel_type, vehicle_class: c.vehicle_class})
    |> limit(^max_elements)
    |> offset(^offset)
  end


  defp map_and_return_result(query) do
    query
    |> order_by([c], desc: c.year, asc: c.make, asc: c.model)
    |> Repo.all
    |> Enum.map(fn result -> Map.from_struct(result) end)
    |> Enum.map(fn item -> %Vehicle{
         id: UUID.binary_to_string!(item.id), make: item.make, model: item.model,
         year: item.year, fuel_type_primary: item.fuel_type_primary,
         fuel_type_secondary: item.fuel_type_secondary, fuel_type: item.fuel_type,
         manufacturer_code: item.manufacturer_code, record_id: item.record_id,
         alternative_fuel_type: item.alternative_fuel_type, vehicle_class: item.vehicle_class} end)
  end

end