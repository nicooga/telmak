defmodule Telmak.Repo do
  use Ecto.Repo, otp_app: :telmak

  import Ecto.Query

  def find_or_create_by(queryable, attrs) do
    attrs
    |> Enum.reduce(queryable, fn({field, val}, query) ->
      query |> where([x], field(x, ^field) == ^val)
    end)
    |> all()
    |> case do
      [] -> insert!(struct(queryable, attrs))
      [record] -> record
    end
  end
end
