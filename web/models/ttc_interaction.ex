defmodule Telmak.TtcInteraction do
  use Telmak.Web, :model
  alias Telmak.{PhoneNumber, User}

  schema "ttc_interactions" do
    field :kind, :string
    field :date, Ecto.DateTime
    timestamps

    belongs_to :telemarketer, User
    belongs_to :customer, User
    belongs_to :phone_number, PhoneNumber
  end

  @required_fields ~w(telemarketer_id kind date)
  @optional_fields ~w(phone_number_id customer_id)

  def changeset(model, params \\ :empty)

  def changeset(model, params) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

