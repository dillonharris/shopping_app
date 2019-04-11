defmodule ShoppingAppWeb.ItemView do
  use ShoppingAppWeb, :view

  alias ShoppingApp.Repo
  alias ShoppingApp.Accounts.User
  alias ShoppingApp.Accounts
  alias ShoppingApp.Shopping
  alias ShoppingApp.Shopping.List

  alias ShoppingApp.Session

  import Session, only: [current_user: 1]

  def number_to_rands(price) do
    Number.Currency.number_to_currency(price, unit: "R", precision: 2)
  end

  def collection_of_users do
    user_collection = Enum.map(Repo.all(User), fn u -> [u.name, u.id] end)

    Enum.reduce(user_collection, %{}, fn [k, v], acc -> Map.merge(acc, %{k => v}) end)
  end

  def collection_of_list do
    list_collection = Enum.map(Repo.all(List), fn u -> [u.name, u.id] end)

    Enum.reduce(list_collection, %{}, fn [k, v], acc -> Map.merge(acc, %{k => v}) end)
  end

  def set_user_name(user_id) do
    Accounts.get_user!(user_id).name
  end

  def set_list_name(list_id) do
    Shopping.get_list!(list_id).name
  end
end
