defmodule Telmak.Repo.Migrations.CreateGeoPoint do
  use Ecto.Migration

  def change do
    create table(:geo_points) do
      add :street_name, :string
      add :street_number, :integer
      add :floor_number, :integer
      add :apartment_name, :string

      timestamps
    end
  end
end
