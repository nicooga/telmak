defmodule Telmak.Commitment do
  use Telmak.Web, :model

  schema "commitments" do
    field :date, Ecto.DateTime
    field :kind, :string
    belongs_to :telemarketer, Telmak.User
    belongs_to :customer, Telmak.User
    belongs_to :geo_point, Telmak.GeoPoint
    belongs_to :phone_number, Telmak.PhoneNumber

    timestamps
  end

  @required_fields ~w(date kind)
  @optional_fields ~w(phone_number_id geo_point_id telemarketer_id customer_id)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
