defmodule Telmak.PhoneNumber do
  use Telmak.Web, :model

  schema "phone_numbers" do
    field :number, :string
    field :dont_call, :boolean
    timestamps
  end

  @required_fields ~w(number)
  @optional_fields ~w(dont_call)

  def changeset(model, params \\ :empty)

  def changeset(model, params) do
    model
    |> cast(prepare_params(params), @required_fields, @optional_fields)
    |> unique_constraint(:number)
  end

  defp prepare_params(params) do
    params
    |> Map.update("number", nil, &to_string/1)
  end
end
