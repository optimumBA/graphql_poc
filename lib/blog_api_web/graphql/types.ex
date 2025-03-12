defmodule BlogApiWeb.GraphQL.Types do
  use Absinthe.Schema.Notation

  alias BlogApiWeb.GraphQL.Types

  import_types Types.{PostType, UserType, SessionType}
end
