defmodule ShoppingAppWeb.ListView do
  use ShoppingAppWeb, :view

  alias ShoppingApp.Accounts

  def set_user_name(user_id) do
    Accounts.get_user!(user_id).name
  end
end
