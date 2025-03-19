defmodule BlogApi.AccountsTest do
  use BlogApi.DataCase

  alias BlogApi.Accounts

  describe "users" do
    alias BlogApi.Accounts.User

    import BlogApi.AccountsFixtures

    @invalid_attrs %{email: nil, password_hash: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      users = Accounts.list_users()
      assert length(users) == 1
      assert users |> List.first() |> Map.get(:email) == user.email
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()

      registered_user = Accounts.get_user!(user.id)
      assert registered_user.email == user.email
      assert Bcrypt.verify_pass(user.password, registered_user.password_hash)
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        email: "some@email",
        password: "Password123456789",
        password_confirmation: "Password123456789"
      }

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.email == "some@email"
      assert Bcrypt.verify_pass(valid_attrs.password, user.password_hash)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        email: "someupdated@email",
        password: "Password123456789",
        password_confirmation: "Password123456789"
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.email == "someupdated@email"
      assert Bcrypt.verify_pass(update_attrs.password, user.password_hash)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      registered_user = Accounts.get_user!(user.id)
      assert registered_user.email == user.email
      assert Bcrypt.verify_pass(user.password, registered_user.password_hash)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
