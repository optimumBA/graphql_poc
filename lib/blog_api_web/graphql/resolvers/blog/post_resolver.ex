defmodule BlogApiWeb.GraphQL.Resolvers.Blog.PostResolver do
  alias BlogApi.{Accounts, Blog}

  @spec all_posts(any, any, any) :: {:ok, list(Blog.Post.t())}
  def all_posts(%Accounts.User{} = author, args, _) do
    case Blog.list_posts(author, args) do
      nil -> {:error, "Posts not found"}
      posts -> {:ok, posts}
    end
  end

  def all_posts(_root, args, _info) do
    case Blog.list_posts(args) do
      nil -> {:error, "Posts not found"}
      posts -> {:ok, posts}
    end
  end

  @spec get_post(any, any, any) :: {:ok, Blog.Post.t()} | {:error, String.t()}
  def get_post(_, args, _) do
    case Blog.get_post(args.id) do
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
end
