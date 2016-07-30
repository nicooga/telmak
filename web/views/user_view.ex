defmodule Telmak.UserView do
  use Telmak.Web, :view

  attributes ~w(id email first_name last_name external_avatar_url)a
  preload [:phone_numbers, :geo_points]

  has_many :phone_numbers, serializer: Telmak.PhoneNumberView
  has_many :geo_points, serializer: Telmak.GeoPointView

  def type, do: "users"
end
