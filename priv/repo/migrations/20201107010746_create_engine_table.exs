defmodule CarData.Repo.Migrations.CreateEngineTable do
  use Ecto.Migration
  alias CarData.Schema.Types.DriveType

  def change do
    create table(:engine, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :cylinders, :float
      add :displacement, :float
      add :engine_id, :int
      add :engine_descriptor, :string
      add :ev_motor, :string
      add :is_supercharged, :boolean
      add :is_turbocharged, :boolean
      add :drive_type, :string
      add :vehicle_id, references(:vehicle, on_delete: :delete_all, type: :uuid)
    end

    create constraint("engine", :drive_type_must_be_recognized, check: """
    drive_type in ('#{DriveType.two_wheel_drive.name}', '#{DriveType.four_wheel_drive.name}',
    '#{DriveType.four_wd_or_awd.name}', '#{DriveType.awd.name}',
    '#{DriveType.fwd.name}', '#{DriveType.pt4wd.name}', '#{DriveType.rwd.name}')
    """)

  end
end
