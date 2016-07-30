defmodule Telmak.PhoneNumberView do
  use Telmak.Web, :view

  attributes ~w(number dont_call)a
  preload [:users]
  has_many :users, serializer: Telmak.UserView, include: true

  def type, do: "phone_numbers"
end
