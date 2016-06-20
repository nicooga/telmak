defmodule Telmak.Repo.Migrations.AddPhoneNumberIdToTtcInteractions do
  use Ecto.Migration

  def change do
    alter table(:ttc_interactions) do
      add :phone_number_id, references(:phone_numbers, on_delete: :nothing)
    end

    create index(:ttc_interactions, [:phone_number_id])
  end
end
