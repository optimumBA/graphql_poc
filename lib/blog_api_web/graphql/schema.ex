defmodule BlogApiWeb.GraphQL.Schema do
  use Absinthe.Schema

  # datetime, native_datetime, decimal
  import_types Absinthe.Type.Custom
  import_types BlogApiWeb.GraphQL.Types

  alias BlogApiWeb.GraphQL.{Loader, Middleware, Resolvers}

  enum :sort_order do
    value(:asc)
    value(:desc)
  end

  query do
    @desc "Get all posts"
    field :all_posts, list_of(:post_type) do
      arg(:matching, :string)
      arg(:order, type: :sort_order, default_value: :desc)
      resolve(&Resolvers.Blog.PostResolver.all_posts/3)
    end

    @desc "Get a single post"
    field :get_post, :post_type do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Blog.PostResolver.get_post/3)
    end

    @desc "Get all users"
    field :all_users, list_of(:user_type) do
      middleware(Middleware.Authorize)
      resolve(&Resolvers.Accounts.UserResolver.all_users/3)
    end

    @desc "Get a single user"
    field :get_user, :user_type do
      middleware(Middleware.Authorize)
      arg(:id, non_null(:id))
      resolve(&Resolvers.Accounts.UserResolver.get_user/3)
    end
  end

  mutation do
    @desc "Create a new post"
    field :create_post, type: :post_type do
      middleware(Middleware.Authorize)
      arg(:input, non_null(:post_input_type))
      resolve(&Resolvers.Blog.PostResolver.create_post/3)
    end

    @desc "Create a new user"
    field :create_user, type: :user_type do
      arg(:input, non_null(:user_input_type))
      resolve(&Resolvers.Accounts.UserResolver.create_user/3)
    end

    @desc "Login a user and return a JWT token"
    field :login, type: :session_type do
      arg(:input, non_null(:session_input_type))
      resolve(&Resolvers.Accounts.SessionResolver.login_user/3)
    end
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(BlogApi.Blog.Post, Loader.source())
      |> Dataloader.add_source(BlogApi.Accounts.User, Loader.source())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
