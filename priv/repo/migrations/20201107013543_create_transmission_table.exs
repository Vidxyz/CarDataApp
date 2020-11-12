defmodule CarData.Repo.Migrations.CreateTransmissionTable do
  use Ecto.Migration

  def change do
    create table(:transmission, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :transmission_descriptor, :string
      add :type, :string
      add :vehicle_id, references(:vehicle, on_delete: :delete_all, type: :uuid)
    end
  end
end