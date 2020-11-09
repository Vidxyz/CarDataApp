defmodule CarData.Repo.Migrations.CreateDriveTypeTable do
  use Ecto.Migration
  alias CarData.Type.DriveType

  def change do
    create table(:drive_type) do
      add :name, :string
    end

    flush()

    CarData.Repo.insert(DriveType.two_wheel_drive)
    CarData.Repo.insert(DriveType.four_wheel_drive)
    CarData.Repo.insert(DriveType.four_wd_or_awd)
    CarData.Repo.insert(DriveType.awd)
    CarData.Repo.insert(DriveType.fwd)
    CarData.Repo.insert(DriveType.pt4wd)
    CarData.Repo.insert(DriveType.rwd)

  end
end
