defmodule CarData.Repo.Migrations.CreateImageTable do
  use Ecto.Migration

  def change do
    create table(:image, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :vehicle_id, references(:vehicle, on_delete: :delete_all, type: :uuid)
      add :image, :bytea
      add :width, :integer
      add :height, :integer
      timestamps()
    end
  end
end
