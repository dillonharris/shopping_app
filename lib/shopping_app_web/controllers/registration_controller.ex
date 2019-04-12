defmodule ShoppingAppWeb.RegistrationController do
  use ShoppingAppWeb, :controller

  alias ShoppingApp.Repo
  alias ShoppingApp.Accounts.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case ShoppingApp.Registration.create(changeset, Repo) do
      {:ok, changeset} ->
        conn
        |> ShoppingApp.Auth.login(changeset)
        |> put_flash(:info, "Your account was created")
        |> redirect(to: list_path(conn, :my_lists))

      {:error, changeset} ->
        conn
        |> put_flash(:info, "Unable to create account")
        |> render("new.html", changeset: changeset)
    end
  end
end
