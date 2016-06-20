defmodule Telmak.Repo.Migrations.CreateCommitment do
  use Ecto.Migration

  def change do
    create table(:commitments) do
      add :date, :datetime, null: false
      add :kind, :string, null: false
      add :telemarketer_id, references(:users, on_delete: :nilify_all)
      add :customer_id, references(:users, on_delete: :nilify_all)
      add :geo_point_id, references(:geo_points, on_delete: :nilify_all)
      add :phone_number_id, references(:phone_numbers, on_delete: :nilify_all)

      timestamps
    end

    create index(:commitments, [:customer_id])
    create index(:commitments, [:telemarketer_id])
    create index(:commitments, [:geo_point_id])
    create index(:commitments, [:phone_number_id])
  end
end
