defmodule Telmak.User.Identity do
  use Telmak.Web, :model
  alias Telmak.User

  schema "user_identities" do
    field :provider, :string
    field :provider_uid, :string
    belongs_to :user, User
  end

  @required_fields ~w(provider provider_uid user_id)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:user_id)
    |> unique_constraint(:provider)
    |> unique_constraint(:provider_uid)
  end
end
