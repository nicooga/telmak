defmodule Telmak.GeoPoint.PhoneNumberLink do
  use Telmak.Web, :model

  schema "geo_point_phone_number_links" do
    belongs_to :geo_point, Telmak.GeoPoint
    belongs_to :phone_number, Telmak.PhoneNumber

    timestamps
  end

  @required_fields ~w()
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
