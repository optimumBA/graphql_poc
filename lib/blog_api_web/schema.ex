defmodule BlogApiWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types BlogApiWeb.Schema.Types

  alias BlogApiWeb.Resolvers

  query do
    @desc "Get all posts"
    field :all_posts, list_of(:post_type) do
      resolve(&Resolvers.PostResolver.all_posts/3)
    end

    @desc "Get a single post"
    field :get_post, :post_type do
      arg(:id, :id)
      resolve(&Resolvers.PostResolver.get_post/3)
    end

    @desc "Get all users"
    field :all_users, list_of(:user_type) do
      resolve(&Resolvers.UserResolver.all_users/3)
    end

    @desc "Get a single user"
    field :get_user, :user_type do
      arg(:id, :id)
      resolve(&Resolvers.UserResolver.get_user/3)
    end
  end

  mutation do
    @desc "Create a new post"
    field :create_post, type: :post_type do
      arg(:input, non_null(:post_input_type))
      resolve(&Resolvers.PostResolver.create_post/3)
    end

    @desc "Create a new user"
    field :create_user, type: :user_type do
      arg(:input, non_null(:user_input_type))
      resolve(&Resolvers.UserResolver.create_user/3)
    end
  end
end
