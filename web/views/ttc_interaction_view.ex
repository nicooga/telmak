defmodule Telmak.TtcInteractionView do
  use Telmak.Web, :view
  use JaSerializer.PhoenixView

  attributes ~w(kind)a

  def type, do: "ttcInteractions"

  has_one :customer, serializer: Telmak.UserView
  has_one :telemarketer, serializer: Telmak.UserView
end
