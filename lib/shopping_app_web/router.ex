defmodule ShoppingAppWeb.Router do
  use ShoppingAppWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :auth do
    plug(ShoppingApp.Auth.AuthAccessPipeline)
  end

  scope "/", ShoppingAppWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/users", UserController, only: [:new, :create])
    resources("/sessions", SessionController, only: [:new, :create])
    resources("/registrations", RegistrationController, only: [:new, :create])
  end

  scope "/", ShoppingAppWeb do
    pipe_through([:browser, :auth])

    resources("/users", UserController, only: [:index, :show, :edit, :update, :delete])
    resources("/lists", ListController)
    resources("/items", ItemController)
    resources("/sessions", SessionController, only: [:delete])
    get("/lists/user_lists/my_lists", ListController, :my_lists)
  end
end
