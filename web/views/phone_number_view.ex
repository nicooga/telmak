defmodule Telmak.PhoneNumberView do
  use Telmak.Web, :view

  attributes ~w(number dont_call)a
  has_many :users, serializer: Telmak.UserView, include: true

  def type, do: "phone_numbers"

  def users(struct, _conn) do
    case struct.users do
      %Ecto.Association.NotLoaded{} ->
        struct
        |> Ecto.assoc(:users)
        |> Repo.all
      other -> other
    end
  end
end
