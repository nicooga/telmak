defmodule Telmak.Repo.Migrations.CreatePhoneNumber do
  use Ecto.Migration

  def change do
    create table(:phone_numbers) do
      add :number, :string
      add :dont_call, :boolean

      timestamps
    end

    create unique_index(:phone_numbers, [:number])
  end
end
