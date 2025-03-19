defmodule BlogApiWeb.GraphQL.Resolvers.Accounts.UserResolver do
  alias BlogApi.Accounts
  alias BlogApi.Blog
  @spec all_users(any, any, any) :: {:ok, list(map())}
  def all_users(_root, _args, _info) do
    {:ok, Accounts.list_users()}
  end

  @spec create_user(any, any, any) :: {:ok, map()} | {:error, String.t()}
  def create_user(_root, %{input: input} = _args, _info) do
    case Accounts.create_user(input) do
      {:ok, user} -> {:ok, user}
      {:error, changeset} -> {:error, changeset}
    end
  end

  @spec get_user_by_post(any, any, any) :: {:ok, map()} | {:error, String.t()}
  def get_user_by_post(%{user_id: id} = _post, _args, _info) do
    case Accounts.get_user(id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  @spec get_user(any, any, any) :: {:ok, map()} | {:error, String.t()}
  def get_user(_root, %{id: id} = _args, _info) do
    case Accounts.get_user(id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  @spec all_users_with_their_posts(any, any, any) :: {:ok, list(map())}
  def all_users_with_their_posts(_root, _args, _info) do
    {:ok, Accounts.list_users_with_posts()}
  end

  @spec list_posts(map(), map(), map()) :: {:ok, list(map())}
  def list_posts(%Accounts.User{} = user, args, _resolution) do
    case Blog.list_posts(user, args) do
      nil -> {:error, "User not found"}
      posts -> {:ok, posts}
    end
  end

  def list_posts(_parent, args, _info) do
    {:ok, Blog.list_posts(args)}
  end
end
