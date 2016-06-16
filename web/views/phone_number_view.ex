defmodule Telmak.PhoneNumberView do
  use Telmak.Web, :view
  attributes ~w(number dont_call)a
  def type, do: "phone_numbers"
end
