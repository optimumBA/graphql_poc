defmodule BlogApiWeb.Schema do
  use Absinthe.Schema

  alias BlogApiWeb.PostResolver

  import_types Absinthe.Type.Custom
  object :post do
    field :id, :id
    field :title, :string
    field :body, :string
    field :published_at, :naive_datetime
    field :views, :integer
  end

  query do
    @desc "Get all posts"
    field :all_posts, list_of(:post) do
      resolve(&PostResolver.all_posts/3)
    end

    @desc "Get a single post"
    field :get_post, :post do
      arg(:id, :id)
      resolve(&PostResolver.get_post/3)
    end
  end
end
