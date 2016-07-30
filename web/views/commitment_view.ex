defmodule Telmak.CommitmentView do
  use Telmak.Web, :view

  attributes ~w(date kind)a
  preload [:telemarketer, :customer, :geo_point, :phone_number]

  has_one :telemarketer, serializer: Telmak.UserView
  has_one :customer, serializer: Telmak.UserView
  has_one :geo_point, serializer: Telmak.GeoPointView
  has_one :phone_number, serializer: Telmak.PhoneNumberView
end
