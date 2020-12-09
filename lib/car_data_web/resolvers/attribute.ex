defmodule CarDataWeb.Resolvers.Attribute do
  alias CarData.Repo.Vehicle

  def get_distinct_attribute_names(_parent, _args, _resolution) do
    {:ok, Vehicle.get_distinct_attribute_names}
  end

  def get_distinct_attribute_values(_parent, %{attributes: []}, _resolution) do
    {:ok, Vehicle.get_distinct_attribute_values}
  end

  def get_distinct_attribute_values(_parent, %{attributes: attributes}, _resolution) do
    {:ok, Vehicle.get_distinct_attribute_values(attributes)}
  end

  def find_vehicles_by_attributes(_parent, %{
    make: make,
    year: year,
    fuel_type_primary: fuel_type_primary,
    fuel_type_secondary: fuel_type_secondary,
    fuel_type: fuel_type,
    engine_descriptor: engine_descriptor,
    type: type,
    cylinders: cylinders,
    displacement: displacement,
    limit: limit,
    offset: offset,
    sort_by: "",
    order: order
  } ,_resolution) do
    {:ok, Vehicle.find_vehicles_by_attributes(
      %{
        make: make,
        year: year,
        fuel_type_primary: fuel_type_primary,
        fuel_type_secondary: fuel_type_secondary,
        fuel_type: fuel_type,
        engine_descriptor: engine_descriptor,
        type: type,
        cylinders: cylinders,
        displacement: displacement,
      }, limit, offset)}
  end

  def find_vehicles_by_attributes(_parent, %{
    make: make,
    year: year,
    fuel_type_primary: fuel_type_primary,
    fuel_type_secondary: fuel_type_secondary,
    fuel_type: fuel_type,
    engine_descriptor: engine_descriptor,
    type: type,
    cylinders: cylinders,
    displacement: displacement,
    limit: limit,
    offset: offset,
    sort_by: metric,
    order: order
  } ,_resolution) do
    {:ok, Vehicle.find_vehicles_by_attributes(
      %{
        make: make,
        year: year,
        fuel_type_primary: fuel_type_primary,
        fuel_type_secondary: fuel_type_secondary,
        fuel_type: fuel_type,
        engine_descriptor: engine_descriptor,
        type: type,
        cylinders: cylinders,
        displacement: displacement,
      }, limit, offset, metric, order)}
  end

end