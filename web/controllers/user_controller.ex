defmodule Telmak.UserController do
  use Telmak.Web, :controller
  alias Telmak.User

  use Telmak.ResourceController,
    resource_model: User,
    resource_location: &(user_path(&1, :show, &2))
end
