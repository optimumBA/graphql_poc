defmodule BlogApi.Accounts.SessionTest do
  use BlogApi.DataCase
  alias BlogApi.Accounts.Session
  alias BlogApi.AccountsFixtures

  describe "authenticate/1" do
    test "returns ok when credentials are valid" do
      user =
        AccountsFixtures.user_fixture(%{
          email: "test@example.com",
          password: "password123",
          password_confirmation: "password123"
        })

      assert {:ok, authenticated_user} =
               Session.authenticate(%{
                 email: "test@example.com",
                 password: "password123"
               })

      assert authenticated_user.id == user.id
    end

    test "returns error when email is invalid" do
      AccountsFixtures.user_fixture(%{
        email: "test@example.com",
        password: "password123",
        password_confirmation: "password123"
      })

      assert {:error, "Invalid email or password"} =
               Session.authenticate(%{
                 email: "wrong@example.com",
                 password: "password123"
               })
    end

    test "returns error when password is invalid" do
      AccountsFixtures.user_fixture(%{
        email: "test@example.com",
        password: "password123",
        password_confirmation: "password123"
      })

      assert {:error, "Invalid email or password"} =
               Session.authenticate(%{
                 email: "test@example.com",
                 password: "wrongpassword"
               })
    end
  end
end
