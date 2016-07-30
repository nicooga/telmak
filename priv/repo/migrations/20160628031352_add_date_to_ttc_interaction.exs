defmodule Telmak.Repo.Migrations.AddDateToTtcInteraction do
  use Ecto.Migration

  def change do
    alter table(:ttc_interactions) do
      add :date, :datetime
    end
  end
end
