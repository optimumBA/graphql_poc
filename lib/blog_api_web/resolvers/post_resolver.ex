defmodule BlogApiWeb.PostResolver do
  alias BlogApi.Blog

  def all_posts(_, _, _) do
    {:ok, Blog.list_posts()}
  end
end
