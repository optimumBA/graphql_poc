defmodule BlogApiWeb.Graphql.Resolvers.Accounts.UserResolver do
  alias BlogApi.Accounts
  alias BlogApi.Blog
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
  def get_user(%Blog.Post{} = post, _args, _) do
    case Accounts.get_user(post) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  def get_user(_, args, _) do
    case Accounts.get_user(args) do
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

  def list_posts(_parent, args, _) do
    {:ok, Blog.list_posts(args)}
  end
end
