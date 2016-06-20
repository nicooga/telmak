defmodule Telmak.CommitmentTest do
  use Telmak.ModelCase

  alias Telmak.Commitment

  @valid_attrs %{date: "2010-04-17 14:00:00", kind: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Commitment.changeset(%Commitment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Commitment.changeset(%Commitment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
