defmodule Telmak.User.PhoneNumberLink do
  use Telmak.Web, :model

  schema "user_phone_number_links" do
    belongs_to :user, Telmak.User
    belongs_to :phone_number, Telmak.PhoneNumber

    timestamps
  end

  @required_fields ~w(user_id phone_number_id)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
