defmodule Telmak.Repo.Migrations.AddUniqueIndexToEmail do
  use Ecto.Migration

  def change, do: create unique_index(:users, [:email])
end
