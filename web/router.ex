defmodule Telmak.Router do
  use Telmak.Web, :router

  pipeline :jsonapi do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api", Telmak do
    pipe_through :jsonapi
    resources "/ttc_interactions", TtcInteractionController, except: ~w(new edit)a
  end
end
