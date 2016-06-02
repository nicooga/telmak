defmodule Telmak.TtcInteractionView do
  use Telmak.Web, :view
  use JaSerializer.PhoenixView

  attributes ~w(telemarketer client type)a
end
