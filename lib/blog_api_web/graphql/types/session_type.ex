defmodule BlogApiWeb.GraphQL.Types.SessionType do
  use Absinthe.Schema.Notation

  object :session_type do
    field :token, :string
    # Grabs the user from the token
    field :user, :user_type
  end

  input_object :session_input_type do
    field :email, non_null(:string)
    field :password, non_null(:string)
  end
end
