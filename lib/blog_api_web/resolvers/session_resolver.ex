defmodule BlogApiWeb.Resolvers.SessionResolver do
  alias BlogApi.Accounts

  def login_user(_, %{input: input}, _) do
    # check if user is in our db
    # if a user is found, generate a token and return it
    # and the user
    with {:ok, user} <- Accounts.Session.authenticate(input) do
      # {:ok, %{token: jwt_token, user: user}}
      {:ok, %{user: user}}
    end
  end
end
