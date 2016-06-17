defmodule Telmak.TtcInteractionView do
  use Telmak.Web, :view

  attributes ~w(kind)a

  def type, do: "ttc_interactions"

  has_one :customer, serializer: Telmak.UserView, include: true
  has_one :telemarketer, serializer: Telmak.UserView, include: true

  def telemarketer(struct, _conn) do
    case struct.telemarketer do
      %Ecto.Association.NotLoaded{} ->
        struct
        |> Ecto.assoc(:telemarketer)
        |> Repo.all
      other -> other
    end
  end

  def customer(struct, _conn) do
    case struct.customer do
      %Ecto.Association.NotLoaded{} ->
        struct
        |> Ecto.assoc(:customer)
        |> Repo.all
      other -> other
    end
  end
end
