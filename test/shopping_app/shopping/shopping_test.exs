defmodule ShoppingApp.ShoppingTest do
  use ShoppingApp.DataCase

  alias ShoppingApp.Shopping

  alias ShoppingApp.Repo

  alias ShoppingApp.Accounts.User
  alias ShoppingApp.Accounts
  alias ShoppingApp.Shopping.List

  describe "lists" do
    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}
    @valid_user_attrs %{email: "email@example.com", is_active: true, password: "some password"}

    def list_fixture(attrs \\ %{}) do
      {:ok, list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shopping.create_list()

      list =
        Repo.get!(
          from(l in List,
            preload: [:items]
          ),
          list.id
        )
    end

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_user_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_lists/0 returns all lists" do
      user = user_fixture()

      list = list_fixture(user_id: user.id)
      assert Shopping.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      user = user_fixture()

      list = list_fixture(user_id: user.id)
      assert Shopping.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      user = user_fixture()

      assert {:ok, %List{} = list} =
               Shopping.create_list(Map.put(@valid_attrs, :user_id, user.id))

      assert list.name == "some name"
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shopping.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      user = user_fixture()
      list = list_fixture(user_id: user.id)

      assert {:ok, list} = Shopping.update_list(list, @update_attrs)
      assert %List{} = list
      assert list.name == "some updated name"
    end

    test "update_list/2 with invalid data returns error changeset" do
      user = user_fixture()
      list = list_fixture(user_id: user.id)

      assert {:error, %Ecto.Changeset{}} = Shopping.update_list(list, @invalid_attrs)
      assert list == Shopping.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      user = user_fixture()
      list = list_fixture(user_id: user.id)

      assert {:ok, %List{}} = Shopping.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Shopping.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      user = user_fixture()
      list = list_fixture(user_id: user.id)

      assert %Ecto.Changeset{} = Shopping.change_list(list)
    end
  end

  describe "items" do
    alias ShoppingApp.Shopping.Item

    @valid_attrs %{
      item_type: "some item_type",
      name: "some name",
      price: "some price",
      repeat: "never"
    }
    @update_attrs %{
      item_type: "some updated item_type",
      name: "some updated name",
      price: "some updated price",
      repeat: ""
    }
    @invalid_attrs %{item_type: nil, name: nil, price: nil, repeat: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shopping.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()

      assert Shopping.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Shopping.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Shopping.create_item(@valid_attrs)
      assert item.item_type == "some item_type"
      assert item.name == "some name"
      assert item.price == "some price"
      assert item.repeat == "never"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shopping.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, item} = Shopping.update_item(item, @update_attrs)
      assert %Item{} = item
      assert item.item_type == "some updated item_type"
      assert item.name == "some updated name"
      assert item.price == "some updated price"
      assert item.repeat == "never"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Shopping.update_item(item, @invalid_attrs)
      assert item == Shopping.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Shopping.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Shopping.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Shopping.change_item(item)
    end
  end
end
