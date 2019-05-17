defmodule ShoppingApp.Shopping.Item do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field(:item_type, :string)
    field(:name, :string)
    field(:price, :string)
    field(:quantity, :string)
    field(:repeat, :string, default: "never")
    field(:user_id, :id)
    field(:list_id, :id)

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :repeat, :price, :item_type, :user_id, :list_id, :quantity])
    |> validate_required([:name, :repeat, :price, :item_type])
  end
end
