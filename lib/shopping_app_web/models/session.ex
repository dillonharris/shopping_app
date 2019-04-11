defmodule ShoppingApp.Session do
  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def logged_in?(conn) do
    !!current_user(conn)
  end
end
