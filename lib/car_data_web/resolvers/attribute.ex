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

end