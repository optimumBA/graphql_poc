defmodule BlogApiWeb.Schema.Types.UserType do
  use Absinthe.Schema.Notation

  object :user_type do
    field :id, :id
    field :email, :string
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
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
