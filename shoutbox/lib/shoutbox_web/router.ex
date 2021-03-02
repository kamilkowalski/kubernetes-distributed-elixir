defmodule ShoutboxWeb.Router do
  use ShoutboxWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ShoutboxWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/users", UserController)

    live_dashboard("/dashboard", metrics: ShoutboxWeb.Telemetry)
  end
end
