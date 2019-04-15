defmodule ShoppingAppWeb.ListController do
  use ShoppingAppWeb, :controller

  alias ShoppingApp.Shopping
  alias ShoppingApp.Shopping.List
  alias ShoppingApp.Repo
  alias ShoppingApp.Session

  import Session, only: [current_user: 1]

  def index(conn, _params) do
    lists = Shopping.list_lists()

    render(conn, "index.html", lists: lists)
  end

  def new(conn, _params) do
    changeset = Shopping.change_list(%List{})
    render(conn, "new.html", changeset: changeset)
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

    list_items = Repo.preload(list, :items).items
    render(conn, "show.html", list: list, list_items: list_items)
  end

  def edit(conn, %{"id" => id}) do
    list = Shopping.get_list!(id)
    changeset = Shopping.change_list(list)
    render(conn, "edit.html", list: list, changeset: changeset)
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

  def my_lists(conn, _) do
    lists = Shopping.list_lists()

    current_user_lists = Repo.preload(current_user(conn), [:lists, :items]).lists

    render(conn, "my_lists.html",
      lists: lists,
      current_user_lists: current_user_lists
    )
  end

  def shopping_time(conn, %{"id" => id}) do
    list = Shopping.get_list!(id)

    list_items = Repo.preload(list, :items).items

    render(conn, "shopping_time.html",
      list_items: list_items,
      list: list
    )
  end
end
