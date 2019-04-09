defmodule ShoppingAppWeb.ListController do
  use ShoppingAppWeb, :controller

  alias ShoppingApp.Shopping
  alias ShoppingApp.Shopping.List

  def index(conn, _params) do
    lists = Shopping.list_lists()
    current_user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", lists: lists, current_user: current_user)
  end

  def new(conn, _params) do
    changeset = Shopping.change_list(%List{})
    current_user = Guardian.Plug.current_resource(conn)
    render(conn, "new.html", changeset: changeset, current_user: current_user)
  end

  def create(conn, %{"list" => list_params}) do
    case Shopping.create_list(list_params) do
      {:ok, list} ->
        conn
        |> put_flash(:info, "List created successfully.")
        |> redirect(to: list_path(conn, :show, list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    list = Shopping.get_list!(id)
    current_user = Guardian.Plug.current_resource(conn)
    render(conn, "show.html", list: list, current_user: current_user)
  end

  def edit(conn, %{"id" => id}) do
    list = Shopping.get_list!(id)
    changeset = Shopping.change_list(list)
    current_user = Guardian.Plug.current_resource(conn)
    render(conn, "edit.html", list: list, changeset: changeset, current_user: current_user)
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list = Shopping.get_list!(id)

    case Shopping.update_list(list, list_params) do
      {:ok, list} ->
        conn
        |> put_flash(:info, "List updated successfully.")
        |> redirect(to: list_path(conn, :show, list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", list: list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Shopping.get_list!(id)
    {:ok, _list} = Shopping.delete_list(list)

    conn
    |> put_flash(:info, "List deleted successfully.")
    |> redirect(to: list_path(conn, :index))
  end
end
