defmodule BlogApiWeb.PostResolver do
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
end
