defmodule CarData.Schema.Types.AlternativeFuelType do
  use Ecto.Schema
  alias CarData.Schema.Types.AlternativeFuelType

  schema "alternative_fuel_type" do
    field :name, :string
    field :description, :string
  end

  def bcng do %AlternativeFuelType{name: "Bifuel (CNG)", description: "Bi-fuel gasoline and compressed natural gas vehicle"} end
  def blpg do %AlternativeFuelType{name: "Bifuel (LPG)", description: "Bi-fuel gasoline and propane vehicle"} end
  def cng do %AlternativeFuelType{name: "CNG", description: "Compressed natural gas vehicle"} end
  def diesel do %AlternativeFuelType{name: "Diesel", description: "Diesel vehicle"} end
  def ev do %AlternativeFuelType{name: "EV", description: "Electric vehicle"} end
  def ffv do %AlternativeFuelType{name: "FFV", description: "Flexible fueled vehicle (gasoline or E85)"} end
  def hybrid do %AlternativeFuelType{name: "Hybrid", description: "Hybrid vehicle"} end
  def plug_in_hybrid do %AlternativeFuelType{name: "Plug-in Hybrid", description: "Plug-in hybrid vehicle"} end

end