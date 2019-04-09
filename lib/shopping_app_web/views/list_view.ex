defmodule ShoppingAppWeb.ListView do
  use ShoppingAppWeb, :view

  alias ShoppingApp.Accounts
  alias ShoppingApp.Repo
  alias ShoppingApp.Accounts.User

  def set_user_name(user_id) do
    Accounts.get_user!(user_id).name
  end

  def collection_of_users do
    user_collection = Enum.map(Repo.all(User), fn u -> [u.name, u.id] end)

    Enum.reduce(user_collection, %{}, fn [k, v], acc -> Map.merge(acc, %{k => v}) end)
  end
end
