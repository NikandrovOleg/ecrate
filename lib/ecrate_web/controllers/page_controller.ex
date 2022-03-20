defmodule EcrateWeb.PageController do
  use EcrateWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
