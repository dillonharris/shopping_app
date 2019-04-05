defmodule ShoppingApp.Shopping.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lists" do
    field(:name, :string)
    field(:user_id, :id)

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
