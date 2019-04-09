defmodule ShoppingAppWeb.SessionController do
  use ShoppingAppWeb, :controller

  def new(conn, _) do
    current_user = Guardian.Plug.current_resource(conn)
    render(conn, "new.html", current_user: current_user)
  end

  def create(conn, %{"session" => %{"email" => user, "password" => password}}) do
    case ShoppingApp.Auth.authenticate_user(user, password) do
      {:ok, user} ->
        conn
        |> ShoppingApp.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: user_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> ShoppingApp.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end
end
