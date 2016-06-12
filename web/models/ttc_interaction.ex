defmodule Telmak.TtcInteraction do
  use Telmak.Web, :model
  alias Telmak.{Repo, PhoneNumber, User}

  schema "ttc_interactions" do
    field :kind, :string
    timestamps

    belongs_to :telemarketer, User
    belongs_to :customer, User
  end

  @required_fields ~w(telemarketer_id customer_id kind)
  @optional_fields ~w()

  def changeset(model, params \\ :empty)

  def changeset(model, params = %{
    "kind" => "call",
    "metadata" => %{"phone_number" => pn}
  }) do
    customer =
      PhoneNumber
      |> Repo.get_or_create_by!(number: to_string(pn))
      |> User.get_or_create_by_phone_number

    model |> changeset(
      params
      |> Map.delete("metadata")
      |> Map.put("customer_id", customer.id)
    )
   end

  def changeset(model, params) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

