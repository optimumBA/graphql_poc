defmodule BlogApi.GuardianTest do
  use BlogApi.DataCase
  alias BlogApi.Guardian
  alias BlogApi.AccountsFixtures

  describe "subject_for_token/2" do
    test "returns ok tuple with subject when given valid user" do
      user = AccountsFixtures.user_fixture()
      assert {:ok, sub} = Guardian.subject_for_token(user, %{})
      assert sub == to_string(user.id)
    end

    test "returns error tuple when given invalid resource" do
      assert {:error, :reason_for_error} = Guardian.subject_for_token(%{}, %{})
    end
  end

  describe "resource_from_claims/1" do
    test "returns ok tuple with user when given valid claims" do
      user = AccountsFixtures.user_fixture()
      assert {:ok, retrieved_user} = Guardian.resource_from_claims(%{"sub" => user.id})
      assert retrieved_user.id == user.id
    end

    test "returns error tuple when given invalid claims" do
      assert {:error, :reason_for_error} = Guardian.resource_from_claims(%{})
    end
  end
end
