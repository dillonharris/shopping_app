defmodule ShoppingAppWeb.SessionController do
  use ShoppingAppWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => user, "password" => password}}) do
    case ShoppingApp.Auth.authenticate_user(user, password) do
      {:ok, user} ->
        conn
        |> ShoppingApp.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: list_path(conn, :my_lists))

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
