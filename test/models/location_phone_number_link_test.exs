defmodule Telmak.LocationPhoneNumberLinkTest do
  use Telmak.ModelCase

  alias Telmak.LocationPhoneNumberLink

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = LocationPhoneNumberLink.changeset(%LocationPhoneNumberLink{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = LocationPhoneNumberLink.changeset(%LocationPhoneNumberLink{}, @invalid_attrs)
    refute changeset.valid?
  end
end
