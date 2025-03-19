defmodule BlogApiWeb.GraphQL.Types.UserType do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers

  alias BlogApi.Accounts.User

  object :user_type do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :inserted_at, non_null(:naive_datetime)
    field :updated_at, non_null(:naive_datetime)

    field :posts, list_of(:post_type), resolve: dataloader(Post)
  end

  input_object :user_input_type do
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :password_confirmation, non_null(:string)
  end

  input_object :user_login_input_type do
    field :email, non_null(:string)
    field :password, non_null(:string)
  end
end
