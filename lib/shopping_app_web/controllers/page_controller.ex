defmodule ShoppingAppWeb.PageController do
  use ShoppingAppWeb, :controller

  def index(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", current_user: current_user)
  end
end
