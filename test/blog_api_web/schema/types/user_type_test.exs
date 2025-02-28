defmodule BlogApiWeb.Schema.Types.UserTypeTest do
  use BlogApi.DataCase
  alias BlogApiWeb.Schema
  alias BlogApi.AccountsFixtures

  describe "user queries" do
    test "get_user returns user by id" do
      user = AccountsFixtures.user_fixture()

      query = """
      query GetUser($id: ID!) {
        get_user(id: $id) {
          id
          email
        }
      }
      """

      context = %{current_user: user}

      assert {:ok, %{data: %{"get_user" => user_data}}} =
               Absinthe.run(query, Schema,
                 variables: %{"id" => user.id},
                 context: context
               )

      assert user_data["id"] == to_string(user.id)
      assert user_data["email"] == user.email
    end
  end
end
