defmodule Telmak.User do
  use Telmak.Web, :model
  alias Telmak.{Repo, PhoneNumber, TtcInteraction}

  schema "users" do
    field :email, :string
    timestamps

    has_many :user_phone_number_links, __MODULE__.PhoneNumberLink
    has_many :phone_numbers,
      through: [:user_phone_number_links, :phone_number],
      on_delete: :delete_all

    has_many :ttc_interactions_as_telemarketer, TtcInteraction, foreign_key: :telemarketer_id 
    has_many :ttc_interactions_as_client, TtcInteraction, foreign_key: :client_id
  end

  @required_fields ~w(email)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def find_or_create_by_phone_number(%PhoneNumber{} = pn) do
    Repo.all(from u in __MODULE__,
     join: p in assoc(u, :phone_numbers),
     where: p.id == ^pn.id
    ) |> case do
      [user] -> user
      [] ->
        user = struct(__MODULE__) |> Repo.insert!

        user
        |> build_assoc(:user_phone_number_links, phone_number_id: pn.id)
        |> Repo.insert!

        user
    end
  end
end
