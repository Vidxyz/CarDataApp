defmodule CarData.Repo.Migrations.CreateTransmissionTable do
  use Ecto.Migration

  def change do
    create table(:transmission, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :descriptor, :string
      add :type, :string
    end
  end
end