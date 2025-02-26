defmodule BlogApiWeb.Resolvers.UserResolver do
  alias BlogApi.Accounts

  def create_user(_, %{input: input}, _) do
    case Accounts.create_user(input) do
      {:ok, user} -> {:ok, user}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def get_user(_, %{id: id}, _) do
    case Accounts.get_user(id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
