defmodule Telmak.Repo do
  use Ecto.Repo, otp_app: :telmak

  def get_or_create_by!(queryable, attrs) when is_list(attrs),
    do: get_or_create_by!(queryable, Enum.into(attrs, %{}))
  def get_or_create_by(queryable, attrs) when is_list(attrs),
    do: get_or_create_by(queryable, Enum.into(attrs, %{}))

  def get_or_create_by(queryable, attrs) do
    queryable
    |> get_by(attrs)
    |> case do
      nil ->
        record =
          struct(queryable)
          |> queryable.changeset(attrs)
          |> insert!

        {:created, record}
      record -> {:gotten, record}
    end
  end

  def get_or_create_by!(queryable, attrs) do
    {_, record} = get_or_create_by(queryable, attrs)
    record
  end
end
