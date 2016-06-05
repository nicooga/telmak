defmodule Telmak.AuthController do
  use Telmak.Web, :controller
  alias Telmak.User
  plug Ueberauth

  def callback(conn = %Plug.Conn{assigns: %{ueberauth_auth: auth}}, _params) do
    user = User.find_or_create_by_auth!(auth)

    conn
    |> Guardian.Plug.api_sign_in(user)
    |> set_token_to_text
  end

  defp set_token_to_text(conn) do
    conn |> text(conn.private.guardian_default_jwt)
  end
end
