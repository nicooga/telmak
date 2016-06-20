defmodule Telmak.CommitmentView do
  use Telmak.Web, :view

  attributes ~w(date kind)a
  has_one :telemarketer, serializer: Telmak.UserView, include: true
  has_one :customer, serializer: Telmak.UserView, include: true
  has_one :geo_point, serializer: Telmak.GeoPointView, include: true
  has_one :phone_number, serializer: Telmak.PhoneNumberView, include: true

  for assoc <- ~w(telemarketer customer geo_point phone_number)a do
    def unquote(assoc)(struct, _conn) do
      case struct.unquote(assoc) do
        %Ecto.Association.NotLoaded{} ->
          struct
          |> Ecto.assoc(unquote(assoc))
          |> Repo.all
        other -> other
      end
    end
  end
end
