defmodule BlogApiWeb.GraphQL.Loader do
  @moduledoc """
  A module encapsulating custom dataloader behaviour.

  Dataloader provides a mechanism for loading data in batches
  to avoid the N+1 queries problem.

  See https://hexdocs.pm/absinthe/dataloader.html for more details.
  """

  alias BlogApi.Repo

  def source do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  # def query(Post, _params), do: Post

  # def query(User, _params), do: User

  def query(queryable, _params) do
    queryable
  end
end
