defmodule BlogApiWeb.Plugs.ContextTest do
  use BlogApiWeb.ConnCase
  alias BlogApiWeb.Plugs.Context
  alias BlogApi.Guardian
  alias BlogApi.AccountsFixtures

  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  describe "call/2" do
    test "adds current_user to context when token is valid", %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> Context.call(%{})

      assert %{context: %{current_user: current_user}} = conn.private.absinthe
      assert current_user.id == user.id
    end

    test "adds empty context when no token is provided", %{conn: conn} do
      conn = Context.call(conn, %{})
      assert %{context: %{}} = conn.private.absinthe
    end

    test "adds empty context when token is invalid", %{conn: conn} do
      conn =
        conn
        |> put_req_header("authorization", "Bearer invalid_token")
        |> Context.call(%{})

      assert %{context: %{}} = conn.private.absinthe
    end
  end
end
