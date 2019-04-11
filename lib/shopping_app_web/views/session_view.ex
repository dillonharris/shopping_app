defmodule ShoppingAppWeb.SessionView do
  use ShoppingAppWeb, :view

  alias ShoppingApp.Session

  import Session, only: [current_user: 1, logged_in?: 1]
end
