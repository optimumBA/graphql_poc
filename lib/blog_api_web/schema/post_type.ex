defmodule BlogApiWeb.Schema.Types.PostType do
  use Absinthe.Schema.Notation

  object :post do
    field :id, :id
    field :title, :string
    field :body, :string
    field :published_at, :naive_datetime
    field :views, :integer
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  input_object :post_input do
    field :title, :string
    field :body, :string
  end
end
