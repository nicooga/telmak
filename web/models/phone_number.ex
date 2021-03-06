defmodule Telmak.PhoneNumber do
  use Telmak.Web, :model

  schema "phone_numbers" do
    field :number, :string
    field :dont_call, :boolean
    timestamps

    has_many :phone_number_links, Telmak.User.PhoneNumberLink
    has_many :users,
      through: [:phone_number_links, :user],
      on_delete: :nilify_all
  end

  @required_fields ~w(number)
  @optional_fields ~w(dont_call)

  def changeset(model, params \\ :empty) do
    parsed_params = parse_params(model, params)

    model
    |> cast(parsed_params, @required_fields, @optional_fields)
    |> unique_constraint(:number)
  end

  defp parse_params(model, params) do
    params |> Map.update("number", model.number, &to_string/1)
  end
end
