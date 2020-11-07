defmodule CarData.DriveType do
  use Ecto.Schema

  schema "drive_type" do
    field :name, :string
  end

  def two_wheel_drive do %CarData.DriveType{name: "2-Wheel Drive"} end
  def four_wheel_drive do %CarData.DriveType{name: "4-Wheel Drive"} end
  def four_wd_or_awd do %CarData.DriveType{name: "4-Wheel or All-Wheel Drive"} end
  def awd do %CarData.DriveType{name: "All-Wheel Drive"} end
  def fwd do %CarData.DriveType{name: "Front-Wheel Drive"} end
  def pt4wd do %CarData.DriveType{name: "Part-Time 4-Wheel Drive"} end
  def rwd do %CarData.DriveType{name: "Rear-Wheel Drive"} end

end