defmodule BlogApiWeb.Resolvers.UserResolver do
  alias BlogApi.Accounts

  @spec all_users(any, any, any) :: {:ok, list(map())}
  def all_users(_root, _args, _info) do
    {:ok, Accounts.list_users()}
  end

  @spec create_user(any, any, any) :: {:ok, map()} | {:error, String.t()}
  def create_user(_, %{input: input}, _) do
    case Accounts.create_user(input) do
      {:ok, user} -> {:ok, user}
      {:error, changeset} -> {:error, changeset}
    end
  end

  @spec get_user(any, any, any) :: {:ok, map()} | {:error, String.t()}
  def get_user(_, %{id: id}, _) do
    case Accounts.get_user(id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  @spec all_users_with_their_posts(any, any, any) :: {:ok, list(map())}
  def all_users_with_their_posts(_root, _args, _info) do
    {:ok, Accounts.list_users_with_posts()}
  end
end
