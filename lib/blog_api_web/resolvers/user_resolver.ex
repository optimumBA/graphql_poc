defmodule BlogApiWeb.Resolvers.UserResolver do
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

  @spec get_user_posts(map(), map(), map()) :: {:ok, list(map())}
  def get_user_posts(%{id: user_id}, _args, _resolution) do
    case Blog.get_posts_by_user_id(user_id) do
      nil -> {:error, "User not found"}
      posts -> {:ok, posts}
    end
  end

  @spec get_user_by_post(map(), map(), map()) :: {:ok, map()}
  def get_user_by_post(post, _args, _resolution) do
    case Accounts.get_user(post.user_id) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
