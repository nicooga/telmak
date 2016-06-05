defmodule Telmak.Repo do
  use Ecto.Repo, otp_app: :telmak

  import Ecto.Query

  def get_or_create_by!(queryable, attrs) when is_list(attrs),
    do: get_or_create_by!(queryable, Enum.into(attrs, %{}))

  def get_or_create_by!(queryable, attrs) do
    queryable
    |> get_by(attrs)
    |> case do
      nil ->
        struct(queryable)
        |> queryable.changeset(attrs)
        |> insert!
      record -> record
    end
  end
end
