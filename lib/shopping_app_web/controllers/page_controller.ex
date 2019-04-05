defmodule ShoppingAppWeb.PageController do
  use ShoppingAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
