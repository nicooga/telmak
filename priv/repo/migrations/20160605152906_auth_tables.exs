defmodule Telmak.Repo.Migrations.AuthTables do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :external_avatar_url, :string
    end

    create table(:user_identities) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :provider, :string
      add :provider_uid, :string
    end

    create unique_index(:user_identities, ~w[user_id provider provider_uid]a)
  end
end
