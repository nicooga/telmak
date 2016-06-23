defmodule Telmak.User.PhoneNumberLinkController do
  use Telmak.Web, :jsonapi_controller

  def model, do: Telmak.User.PhoneNumberLink
end
