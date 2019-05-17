defmodule ShoppingApp.Accounts.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias ShoppingApp.Shopping.Item
  alias ShoppingApp.Shopping.List

  schema "users" do
    field(:email, :string)
    field(:is_active, :boolean, default: false)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:name, :string)

    has_many(:lists, List)
    has_many(:items, Item)

    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :password, :is_active, :name])
    |> validate_required([:email, :password, :is_active])
    |> validate_format(:email, ~r/.+@.+\..+/, message: "Please input a valid email")
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
