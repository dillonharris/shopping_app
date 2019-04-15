defmodule ShoppingAppWeb.PageView do
  use ShoppingAppWeb, :view

  alias ShoppingApp.Session

  import Session, only: [logged_in?: 1]
end
