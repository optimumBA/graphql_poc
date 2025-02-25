defmodule BlogApi.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BlogApi.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        published_at: ~N[2025-02-24 13:08:00],
        title: "some title",
        views: 42
      })
      |> BlogApi.Blog.create_post()

    post
  end
end
