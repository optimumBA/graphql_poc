defmodule BlogApiWeb.Schema.Types.PostTypeTest do
  use BlogApi.DataCase
  alias BlogApiWeb.Schema
  alias BlogApi.{AccountsFixtures, BlogFixtures}

  describe "query: get_post" do
    test "returns post by id" do
      user = AccountsFixtures.user_fixture()
      post = BlogFixtures.post_fixture(%{user_id: user.id})

      query = """
      query GetPost($id: ID!) {
        get_post(id: $id) {
          id
          title
          body
          user {
            id
            email
          }
        }
      }
      """

      assert {:ok, %{data: %{"get_post" => post_data}}} =
               Absinthe.run(query, Schema, variables: %{"id" => post.id})

      assert post_data["id"] == to_string(post.id)
      assert post_data["title"] == post.title
      assert post_data["body"] == post.body
      assert post_data["user"]["id"] == to_string(user.id)
    end
  end

  describe "mutation: create_post" do
    test "creates a post when user is authenticated" do
      user = AccountsFixtures.user_fixture()

      mutation = """
      mutation CreatePost($input: PostInputType!) {
        create_post(input: $input) {
          id
          title
          body
          user {
            id
          }
        }
      }
      """

      variables = %{
        "input" => %{
          "title" => "Test Post",
          "body" => "Test Body"
        }
      }

      context = %{current_user: user}

      assert {:ok, %{data: %{"create_post" => post_data}}} =
               Absinthe.run(mutation, Schema,
                 variables: variables,
                 context: context
               )

      assert post_data["title"] == "Test Post"
      assert post_data["body"] == "Test Body"
      assert post_data["user"]["id"] == to_string(user.id)
    end

    test "returns error when user is not authenticated" do
      mutation = """
      mutation CreatePost($input: PostInputType!) {
        create_post(input: $input) {
          id
          title
          body
        }
      }
      """

      variables = %{
        "input" => %{
          "title" => "Test Post",
          "body" => "Test Body"
        }
      }

      assert {:ok, %{errors: [%{message: "You must be logged in to perform this action"}]}} =
               Absinthe.run(mutation, Schema,
                 variables: variables,
                 context: %{}
               )
    end
  end

  describe "query: all_posts" do
    test "returns all posts" do
      user = AccountsFixtures.user_fixture()
      post1 = BlogFixtures.post_fixture(%{user_id: user.id, title: "First Post"})
      post2 = BlogFixtures.post_fixture(%{user_id: user.id, title: "Second Post"})

      query = """
      query {
        all_posts {
          id
          title
          body
          user {
            id
          }
        }
      }
      """

      assert {:ok, %{data: %{"all_posts" => posts}}} =
               Absinthe.run(query, Schema)

      assert length(posts) == 2
      assert Enum.any?(posts, fn p -> p["id"] == to_string(post1.id) end)
      assert Enum.any?(posts, fn p -> p["id"] == to_string(post2.id) end)
    end
  end
end
