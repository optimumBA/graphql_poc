defmodule BlogApiWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types BlogApiWeb.Schema.Types

  alias BlogApiWeb.PostResolver

  query do
    @desc "Get all posts"
    field :all_posts, list_of(:post_type) do
      resolve(&PostResolver.all_posts/3)
    end

    @desc "Get a single post"
    field :get_post, :post_type do
      arg(:id, :id)
      resolve(&PostResolver.get_post/3)
    end
  end

  mutation do
    @desc "Create a new post"
    field :create_post, type: :post_type do
      arg(:input, non_null(:post_input_type))
      resolve(&PostResolver.create_post/3)
    end
  end
end
