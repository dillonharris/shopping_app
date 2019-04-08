defmodule ShoppingApp.Repo.Migrations.UpdateItemsTable do
  use Ecto.Migration

  def change do
    alter table(:items) do
      modify(:repeat, :string)
    end
  end
end
