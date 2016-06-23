defmodule Telmak.User.PhoneNumberLinkView do
  use Telmak.Web, :view

  attributes ~w(id phone_number_id user_id)a
  has_one :user, serializer: Telmak.UserView
  has_one :phone_number, serializer: Telmak.PhoneNumberView

  def type, do: "user_phone_number_links"

  for assoc <- ~w(user phone_number)a do
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
