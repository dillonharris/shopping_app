defmodule ShoppingApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias ShoppingApp.Shopping.Item
  alias ShoppingApp.Shopping.List

  schema "users" do
    field(:email, :string)
    field(:is_active, :boolean, default: false)
    field(:password, :string)
    field(:name, :string)

    has_many(:lists, List)
    has_many(:items, Item)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :is_active, :name])
    |> validate_required([:email, :password, :is_active])
    |> validate_format(:email, ~r/.+@.+\..+/, message: "Please input a valid email")
    |> unique_constraint(:email)
  end
end
