defmodule Telmak.UserPhoneNumberLinkTest do
  use Telmak.ModelCase

  alias Telmak.UserPhoneNumberLink

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserPhoneNumberLink.changeset(%UserPhoneNumberLink{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserPhoneNumberLink.changeset(%UserPhoneNumberLink{}, @invalid_attrs)
    refute changeset.valid?
  end
end
