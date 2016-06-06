defmodule Telmak.UserView do
  use Telmak.Web, :view
  use JaSerializer.PhoenixView

  attributes ~w(id email first_name last_name external_avatar_url)a
end
