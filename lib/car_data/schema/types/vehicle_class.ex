defmodule CarData.Schema.Types.VehicleClass do
  use Ecto.Schema
  alias CarData.Schema.Types.VehicleClass

  schema "vehicle_class" do
    field :name, :string
    field :description, :string
  end

  def two_seaters do %VehicleClass{name: "Two-Seaters", description: "Any (cars designed to seat only two adults)"} end
  def mini_compact_cars do %VehicleClass{name: "Minicompact Cars", description: "Less than 85 cu ft."} end
  def sub_compact_cars do %VehicleClass{name: "Subcompact Cars", description: "85 to 99 cu ft."} end
  def compact_cars do %VehicleClass{name: "Compact Cars", description: "100 to 109 cu ft."} end
  def midsize_cars do %VehicleClass{name: "Mid-Size Cars", description: "110 to 119 cu ft."} end
  def large_cars do %VehicleClass{name: "Large Cars", description: "120 or more cu ft."} end
  def small_station_wagons do %VehicleClass{name: "Small Station Wagons", description: "Less than 130 cu ft."} end
  def midsize_station_wagons do %VehicleClass{name: "Mid-Size Cars Station Wagons", description: "130 to 159 cu ft."} end
  def large_cars_station_wagons do %VehicleClass{name: "Large Cars Station Wagons", description: "160 or more cu ft."} end
  def small_pickup_trucks do %VehicleClass{name: "Small Pickup Trucks", description: "Less than 4,500 lbs GVWR through Model Year 2007 \n Less than 6,000 lbs GVWR after Model Year 2008"} end
  def standard_pickup_trucks do %VehicleClass{name: "Standard Pickup Trucks", description: "4,500 to 8,500 lbs GVWR through Model Year 2007 \n 6,000 to 8,500 lbs GVWR after Model Year 2008"} end
  def passenger_vans do %VehicleClass{name: "Passenger Vans", description: "Less than 8,500 lbs GVWR through Model Year 2010 \n Less than 10,000 lbs GVWR beginning Model Year 2011"} end
  def cargo_vans do %VehicleClass{name: "Cargo Vans", description: "Less than 8,500 lbs GVWR"} end
  def minivans do %VehicleClass{name: "Minivans", description: "Less than 8,500 lbs GVWR"} end
  def suvs do %VehicleClass{name: "Sport Utility Vehicles (SUVs) ", description: "Less than 8,500 lbs GVWR through Model Year 2010 \n Less than 10,000 lbs GVWR beginning Model Year 2011"} end
  def small_suvs do %VehicleClass{name: "Small Sport Utility Vehicles (SUVs)", description: "Less than 6,000 lbs GVWR beginning Model Year 2013"} end
  def standard_suvs do %VehicleClass{name: "Small Sport Utility Vehicles (SUVs)", description: "6,000 to 10,000 lbs GVWR beginning Model Year 2013"} end
  def special_purpose_vehicles do %VehicleClass{name: "Special Purpose Vehicles ", description: "Less than 8,500 lbs GVWR through Model Year 2010 \n Less than 10,000 lbs GVWR beginning Model Year 2011"} end

end