defmodule Telmak.Repo do
  use Ecto.Repo, otp_app: :telmak

  def get_or_create_by(queryable, attrs) do
    queryable
    |> get_by(attrs)
    |> case do
      nil ->
        record =
          struct(queryable)
          |> queryable.changeset(attrs |> to_map)
          |> insert!

        {:created, record}
      record -> {:gotten, record}
    end
  end

  def get_or_create_by!(queryable, attrs) do
    {_, record} = get_or_create_by(queryable, attrs)
    record
  end

  defp to_map(map) when is_map(map), do: map
  defp to_map(klist) when is_list(klist) do
    Enum.reduce(klist, %{}, fn({k,v}, m)->
      Map.put(m, to_string(k), v)
    end)
  end
end
