defmodule Telmak.PhoneNumberView do
  use Telmak.Web, :view
  use JaSerializer.PhoenixView

  attributes ~w(number dont_call)a

  def type, do: "phoneNumbers"
end
