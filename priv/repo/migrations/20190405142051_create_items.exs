defmodule ShoppingApp.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :repeat, :boolean, default: false, null: false
      add :price, :string
      add :item_type, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :list_id, references(:lists, on_delete: :nothing)

      timestamps()
    end

    create index(:items, [:user_id])
    create index(:items, [:list_id])
  end
end
