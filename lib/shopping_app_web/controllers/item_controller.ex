defmodule ShoppingAppWeb.ItemController do
  use ShoppingAppWeb, :controller

  alias ShoppingApp.Shopping
  alias ShoppingApp.Shopping.Item

  def index(conn, _params) do
    items = Shopping.list_items()
    render(conn, "index.html", items: items)
  end

  def new(conn, _params) do
    changeset = Shopping.change_item(%Item{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"item" => item_params}) do
    case Shopping.create_item(item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item created successfully.")
        |> redirect(to: list_path(conn, :show, item.list_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Shopping.get_item!(id)
    render(conn, "show.html", item: item)
  end

  def edit(conn, %{"id" => id}) do
    item = Shopping.get_item!(id)
    changeset = Shopping.change_item(item)
    render(conn, "edit.html", item: item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Shopping.get_item!(id)

    case Shopping.update_item(item, item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item updated successfully.")
        |> redirect(to: item_path(conn, :show, item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", item: item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Shopping.get_item!(id)
    {:ok, _item} = Shopping.delete_item(item)

    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: item_path(conn, :index))
  end
end
