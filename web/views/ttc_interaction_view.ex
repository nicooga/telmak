defmodule Telmak.TtcInteractionView do
  use Telmak.Web, :view

  attributes ~w(kind telemarketer_id phone_number_id)a
  preload [:telemarketer, :customer, :phone_number]

  def type, do: "ttc_interactions"

  has_one :customer, serializer: Telmak.UserView, include: true
  has_one :telemarketer, serializer: Telmak.UserView, include: true
  has_one :phone_number, serializer: Telmak.PhoneNumberView, include: true
end
