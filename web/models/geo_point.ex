defmodule Telmak.GeoPoint do
  use Telmak.Web, :model

  schema "geo_points" do
    field :street_name, :string
    field :street_number, :integer
    field :floor_number, :integer
    field :apartment_name, :string

    timestamps
  end

  @required_fields ~w(street_name street_number floor_number apartment_name)
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
