defmodule Telmak.UserView do
  use Telmak.Web, :view
  use JaSerializer.PhoenixView

  attributes ~w(email)a
end
