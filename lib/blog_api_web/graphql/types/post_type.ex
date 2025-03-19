defmodule BlogApiWeb.GraphQL.Types.PostType do
  use Absinthe.Schema.Notation

  alias BlogApiWeb.GraphQL.Resolvers

  object :post_type do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :published_at, non_null(:naive_datetime)
    field :views, non_null(:integer)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)
    field :user_id, non_null(:integer)

    field :user, :user_type do
      resolve &Resolvers.Accounts.UserResolver.get_user_by_post/3
    end
  end

  input_object :post_input_type do
    field :title, non_null(:string)
    field :body, non_null(:string)
  end
end
