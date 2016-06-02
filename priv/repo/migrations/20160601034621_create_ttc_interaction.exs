defmodule Telmak.Repo.Migrations.CreateTtcInteraction do
  use Ecto.Migration

  def change do
    create table(:ttc_interactions) do
      add :telemarketer_id, references(:users, on_delete: :nothing)
      add :client_id, references(:users, on_delete: :nothing)
      add :type, :string

      timestamps
    end

    create index(:ttc_interactions, [:telemarketer_id])
    create index(:ttc_interactions, [:client_id])
  end
end
