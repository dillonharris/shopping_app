defmodule ShoppingApp.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: ShoppingApp.Repo

  def user_factory do
    %ShoppingApp.Accounts.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      is_active: false,
      name: "Test User",
      lists: [],
      items: []
    }
  end

  def list_factory do
    %ShoppingApp.Shopping.List{
      name: "Testing List",
      items: []
    }
  end

  def item_factory do
    %ShoppingApp.Shopping.Item{
      item_type: "Test Type",
      name: "Testing Item",
      price: "50"
    }
  end
end
