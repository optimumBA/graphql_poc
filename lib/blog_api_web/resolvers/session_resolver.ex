defmodule BlogApiWeb.Resolvers.SessionResolver do
  alias BlogApi.Accounts
  alias BlogApi.Guardian
  def login_user(_, %{input: input}, _) do
    # check if user is in our db
    # if a user is found, generate a token and return it
    # and the user
    with {:ok, user} <- Accounts.Session.authenticate(input),
         {:ok, jwt_token, _claims} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt_token, user: user}}
    end
  end
end
