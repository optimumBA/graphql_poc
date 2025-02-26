defmodule BlogApi.Accounts.Session do
  alias BlogApi.Accounts

  def authenticate(input) do
    # user = Repo.get_by(User, email: String.downcase(input.email))
    user = Accounts.get_user_by_email(String.downcase(input.email))

    case check_password(user, input) do
      true -> {:ok, user}
      false -> {:error, "Invalid email or password"}
    end
  end

  defp check_password(user, input) do
    case user do
      nil -> false
      user -> Bcrypt.verify_pass(input.password, user.password_hash)
    end
  end
end
