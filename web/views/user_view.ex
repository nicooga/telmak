defmodule Telmak.UserView do
  use Telmak.Web, :view

  attributes ~w(id email first_name last_name external_avatar_url)a
  has_many :phone_numbers, serializer: Telmak.PhoneNumberView, include: true

  def type, do: "users"

  def phone_numbers(struct, _conn) do
    case struct.phone_numbers do
      %Ecto.Association.NotLoaded{} ->
        struct
        |> Ecto.assoc(:phone_numbers)
        |> Repo.all
      other -> other
    end
  end
end
