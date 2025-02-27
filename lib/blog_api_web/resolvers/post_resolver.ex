defmodule BlogApiWeb.Resolvers.PostResolver do
  alias BlogApi.Blog

  @spec all_posts(any, any, any) :: {:ok, list(Blog.Post.t())}
  def all_posts(_root, _args, _info) do
    {:ok, Blog.list_posts()}
  end

  @spec get_post(any, any, any) :: {:ok, Blog.Post.t()} | {:error, String.t()}
  def get_post(_, %{id: id}, _) do
    case Blog.get_post(id) do
      nil -> {:error, "Post not found"}
      post -> {:ok, post}
    end
  end

  @spec create_post(any, any, any) :: {:ok, Blog.Post.t()} | {:error, String.t()}
  def create_post(_, %{input: input}, %{context: %{current_user: user}}) do
    input = Map.put(input, :user_id, user.id)
    case Blog.create_post(input) do
      {:ok, post} -> {:ok, post}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def create_post(_, _, _) do
  {:error, "Authentication required to create a post"}
end

  @spec get_posts_by_user_id(any, any, any) :: {:ok, list(Blog.Post.t())} | {:error, String.t()}
  def get_posts_by_user_id(_, %{id: id}, _) do
    case Blog.get_posts_by_user_id(id) do
      nil -> {:error, "User not found"}
      posts -> {:ok, posts}
    end
  end
end
