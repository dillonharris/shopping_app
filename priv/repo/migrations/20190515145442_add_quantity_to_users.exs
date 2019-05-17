defmodule ShoppingApp.Repo.Migrations.AddQuantityToUsers do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add(:quantity, :string)
    end
  end
end
