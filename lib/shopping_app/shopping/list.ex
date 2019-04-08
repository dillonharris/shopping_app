defmodule ShoppingApp.Shopping.List do
  use Ecto.Schema
  import Ecto.Changeset

  alias ShoppingApp.Shopping.Item

  schema "lists" do
    field(:name, :string)
    field(:user_id, :id)

    has_many(:items, Item)

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
