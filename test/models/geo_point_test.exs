defmodule Telmak.GeoPointTest do
  use Telmak.ModelCase

  alias Telmak.GeoPoint

  @valid_attrs %{apartment_name: "some content", floor_number: 42, street_name: "some content", street_number: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = GeoPoint.changeset(%GeoPoint{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = GeoPoint.changeset(%GeoPoint{}, @invalid_attrs)
    refute changeset.valid?
  end
end
