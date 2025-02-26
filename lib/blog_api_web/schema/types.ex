defmodule BlogApiWeb.Schema.Types do
  use Absinthe.Schema.Notation

  alias BlogApiWeb.Schema.Types

  import_types Types.PostType
  import_types Types.UserType
end
