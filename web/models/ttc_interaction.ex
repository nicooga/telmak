defmodule Telmak.TtcInteraction do
  use Telmak.Web, :model
  alias Telmak.{Repo, PhoneNumber, User}

  schema "ttc_interactions" do
    field :type, :string
    timestamps

    belongs_to :telemarketer, User
    belongs_to :client, User
  end

  @required_fields ~w(telemarketer_id client_id type)
  @optional_fields ~w()

  def changeset(model, params \\ :empty)

  def changeset(model, %{
    "type" => "call",
    "metadata" => %{"number" => number }
   } = params) do
    client =
      PhoneNumber
      |> Repo.find_or_create_by(number: number)
      |> User.find_or_create_by_phone_number

    model |> changeset(
      params
      |> Map.delete("metadata")
      |> Map.put("client_id", client.id)
    )
   end

  def changeset(model, params) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

