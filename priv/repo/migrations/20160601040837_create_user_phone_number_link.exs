defmodule Telmak.Repo.Migrations.CreateUserPhoneNumberLink do
  use Ecto.Migration

  def change do
    create table(:user_phone_number_links) do
      add :user_id, references(:users, on_delete: :nothing)
      add :phone_number_id, references(:phone_numbers, on_delete: :nothing)

      timestamps
    end

    create index(:user_phone_number_links, [:user_id])
    create index(:user_phone_number_links, [:phone_number_id])
  end
end
