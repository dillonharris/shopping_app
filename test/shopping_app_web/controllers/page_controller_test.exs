defmodule ShoppingAppWeb.PageControllerTest do
  use ShoppingAppWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Your Shopping Application!"
  end
end
