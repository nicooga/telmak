defmodule Telmak.Router do
  use Telmak.Web, :router

  pipeline :jsonapi do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  pipeline :optional_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  pipeline :required_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", Telmak do
    pipe_through :optional_auth

    get "/auth/:provider", AuthController, :request
    post "/auth/:provider/callback", AuthController, :callback

    scope "/api" do
      pipe_through [:jsonapi, :required_auth]

      ja_resources :users
      ja_resources :ttc_interactions
      ja_resources :phone_numbers
      ja_resources :commitments
      ja_resources :geo_points
      resources "/user_phone_number_links", User.PhoneNumberLinkController
    end
  end
end
