defmodule Telmak.Repo.Migrations.CreateLocationPhoneNumberLink do
  use Ecto.Migration

  def change do
    create table(:geo_point_phone_number_links) do
      add :geo_point_id,
        references(:geo_points, on_delete: :nothing)

      add :phone_number_id,
        references(:phone_numbers, on_delete: :nothing)

      timestamps
    end
    create index(:geo_point_phone_number_links, [:geo_point_id])
    create index(:geo_point_phone_number_links, [:phone_number_id])
  end
end
