defmodule BlogApi.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BlogApi.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "test#{System.unique_integer()}@example.com",
        password: "password123",
        password_confirmation: "password123"
      })
      |> BlogApi.Accounts.create_user()

    user
  end
end
