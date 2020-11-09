defmodule CarData.AlternativeFuelType do
  use Ecto.Schema

  schema "alternative_fuel_type" do
    field :name, :string
    field :description, :string
  end

  def bcng do %CarData.AlternativeFuelType{name: "Bifuel (CNG)", description: "Bi-fuel gasoline and compressed natural gas vehicle"} end
  def blpg do %CarData.AlternativeFuelType{name: "Bifuel (LPG)", description: "Bi-fuel gasoline and propane vehicle"} end
  def cng do %CarData.AlternativeFuelType{name: "CNG", description: "Compressed natural gas vehicle"} end
  def diesel do %CarData.AlternativeFuelType{name: "Diesel", description: "Diesel vehicle"} end
  def ev do %CarData.AlternativeFuelType{name: "EV", description: "Electric vehicle"} end
  def ffv do %CarData.AlternativeFuelType{name: "FFV", description: "Flexible fueled vehicle (gasoline or E85)"} end
  def hybrid do %CarData.AlternativeFuelType{name: "Hybrid", description: "Hybrid vehicle"} end
  def plug_in_hybrid do %CarData.AlternativeFuelType{name: "Plug-in Hybrid", description: "Plug-in hybrid vehicle"} end

end