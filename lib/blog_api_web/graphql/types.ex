defmodule BlogApiWeb.Graphql.Types do
  use Absinthe.Schema.Notation

  alias BlogApiWeb.Graphql.Types

  import_types Types.{PostType, UserType, SessionType}
end
