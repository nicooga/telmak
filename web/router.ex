defmodule Telmak.Router do
  use Telmak.Web, :router

  pipeline :jsonapi do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  pipeline :optional_auth do
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  pipeline :required_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api", Telmak do
    pipe_through :optional_auth

    get "/auth/:provider", AuthController, :request
    post "/auth/:provider/callback", AuthController, :callback

    ja_resources :users, only: ~w(show create update)a
    ja_resources :sessions, only: ~w(create delete)a

    # Private
    scope "/", Telmak do
      pipe_through :required_auth
      ja_resources :ttc_interactions
    end
  end
end
