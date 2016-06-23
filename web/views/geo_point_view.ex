defmodule Telmak.GeoPointView do
  use Telmak.Web, :view

  attributes ~w(
    id
    street_name
    street_number
    floor_number
    apartment_name
  )a

  has_one :user, serializer: Telmak.UserView

  def type, do: "geo_points"

  def user(struct, _conn) do
    case struct.user do
      %Ecto.Association.NotLoaded{} ->
        struct
        |> Ecto.assoc(:user)
        |> Repo.all
      other -> other
    end
  end
end
