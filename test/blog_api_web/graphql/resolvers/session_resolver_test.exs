defmodule BlogApiWeb.GraphQL.Resolvers.SessionResolverTest do
  use BlogApi.DataCase
  alias BlogApiWeb.GraphQL.Resolvers.Accounts
  alias BlogApi.AccountsFixtures

  describe "login_user/3" do
    test "returns token and user when credentials are valid" do
      user =
        AccountsFixtures.user_fixture(%{
          email: "test@example.com",
          password: "password123",
          password_confirmation: "password123"
        })

      assert {:ok, %{token: token, user: logged_in_user}} =
               Accounts.SessionResolver.login_user(
                 nil,
                 %{
                   input: %{
                     email: "test@example.com",
                     password: "password123"
                   }
                 },
                 %{}
               )

      assert is_binary(token)
      assert logged_in_user.id == user.id
    end

    test "returns error when credentials are invalid" do
      AccountsFixtures.user_fixture(%{
        email: "test@example.com",
        password: "password123",
        password_confirmation: "password123"
      })

      assert {:error, "Invalid email or password"} =
               Accounts.SessionResolver.login_user(
                 nil,
                 %{
                   input: %{
                     email: "test@example.com",
                     password: "wrongpassword"
                   }
                 },
                 %{}
               )
    end
  end
end
