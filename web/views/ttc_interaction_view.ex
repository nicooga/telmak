defmodule Telmak.TtcInteractionView do
  use Telmak.Web, :view

  attributes ~w(kind)a

  def type, do: "ttc_interactions"

  has_one :customer, serializer: Telmak.UserView, include: true
  has_one :telemarketer, serializer: Telmak.UserView, include: true

  def telemarketer(struct, _conn) do
    case struct.telemarketer do
      %Ecto.Association.NotLoaded{} ->
        struct |> Repo.preload(:telemarketer)
      other -> other
    end
  end

  def customer(struct, _conn) do
    case struct.customer do
      %Ecto.Association.NotLoaded{} ->
        struct |> Repo.preload(:customer)
      other -> other
    end
  end
end
