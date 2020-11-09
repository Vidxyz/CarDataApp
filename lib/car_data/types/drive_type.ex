defmodule CarData.Types.DriveType do
  use Ecto.Schema
  alias CarData.Types.DriveType

  schema "drive_type" do
    field :name, :string
  end

  def two_wheel_drive do %DriveType{name: "2-Wheel Drive"} end
  def four_wheel_drive do %DriveType{name: "4-Wheel Drive"} end
  def four_wd_or_awd do %DriveType{name: "4-Wheel or All-Wheel Drive"} end
  def awd do %DriveType{name: "All-Wheel Drive"} end
  def fwd do %DriveType{name: "Front-Wheel Drive"} end
  def pt4wd do %DriveType{name: "Part-time 4-Wheel Drive"} end
  def rwd do %DriveType{name: "Rear-Wheel Drive"} end

end