ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Telmak.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Telmak.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Telmak.Repo)

