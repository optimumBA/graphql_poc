defmodule BlogApiWeb.Schema.Middleware.Authorize do
  @behaviour Absinthe.Middleware

  def call(resolution, _opts) do
    case resolution.context do
      %{current_user: _current_user} ->
        resolution

      _ ->
        Absinthe.Resolution.put_result(
          resolution,
          {:error, "You must be logged in to perform this action"}
        )
    end
  end
end
