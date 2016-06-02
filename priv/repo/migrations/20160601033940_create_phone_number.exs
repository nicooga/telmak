defmodule Telmak.Repo.Migrations.CreatePhoneNumber do
  use Ecto.Migration

  def change do
    create table(:phone_numbers) do
      add :number, :string

      timestamps
    end
  end
end
