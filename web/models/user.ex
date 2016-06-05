defmodule Telmak.User do
  use Telmak.Web, :model
  alias Telmak.{Repo, PhoneNumber, TtcInteraction}

  schema "users" do
    field :email, :string
    timestamps

    has_many :identities, __MODULE__.Identity, on_delete: :delete_all
    has_many :phone_number_links, __MODULE__.PhoneNumberLink
    has_many :phone_numbers,
      through: [:phone_number_links, :phone_number],
      on_delete: :delete_all
    has_many :ttc_interactions_as_telemarketer, TtcInteraction,
      foreign_key: :telemarketer_id,
      on_delete: :nilify_all
    has_many :ttc_interactions_as_client, TtcInteraction,
      foreign_key: :client_id,
      on_delete: :nilify_all
  end

  @required_fields ~w(email)
  @optional_fields ~w(identities phone_number_links)

  def changeset(model, params \\ :empty) do
    model
    |> Repo.preload(:identities)
    |> Repo.preload(:phone_number_links)
    |> cast(params, @required_fields, @optional_fields)
    |> cast_assoc(:identities)
    |> cast_assoc(:phone_number_links)
    |> unique_constraint(:email)
  end

  def find_or_create_by_phone_number(%PhoneNumber{} = pn) do
    Repo.get(from u in __MODULE__,
     join: p in assoc(u, :phone_numbers),
     where: p.id == ^pn.id
    ) |> case do
      %__MODULE__{} = user -> user
       nil->
        struct(__MODULE__)
        |> changeset(phone_number_links: %{phone_number_id: pn.id})
        |> Repo.insert!
    end
  end

  def find_or_create_by_auth!(%Ueberauth.Auth{
    info: %{email: email},
    provider: provider, uid: uid
  }) do
    user =
      __MODULE__
      |> Repo.get_or_create_by!(email: email)

    identity_attrs = %{
      user_id: user.id,
      provider: to_string(provider),
      provider_uid: uid
    }

    unless Repo.get_by(__MODULE__.Identity, identity_attrs) do
      build_assoc(user, :identities, identity_attrs)
      |> Repo.insert!
    end

    user
  end
end
