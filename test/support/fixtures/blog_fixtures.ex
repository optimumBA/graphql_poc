defmodule BlogApi.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BlogApi.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    user = BlogApi.AccountsFixtures.user_fixture()

    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title",
        user_id: user.id
      })
      |> BlogApi.Blog.create_post()

    post
  end
end
