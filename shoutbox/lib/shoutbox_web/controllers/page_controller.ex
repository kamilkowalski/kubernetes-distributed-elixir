defmodule ShoutboxWeb.PageController do
  use ShoutboxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
