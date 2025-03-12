defmodule BlogApiWeb.Router do
  use BlogApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug BlogApiWeb.Plugs.Context
  end

  scope "/api", BlogApiWeb do
    pipe_through :api
  end

  scope "/graphql" do
    pipe_through :api
    forward "/", Absinthe.Plug, schema: BlogApiWeb.GraphQL.Schema
  end

  scope "/graphiql" do
    pipe_through :api

    forward "/", Absinthe.Plug.GraphiQL,
      schema: BlogApiWeb.GraphQL.Schema,
      # interfaces can be :playground or :simple or :advanced or :playground
      interface: :advanced,
      context: %{pubsub: BlogApiWeb.PubSub}
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:blog_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BlogApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
