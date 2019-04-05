defmodule ShoppingApp.ShoppingTest do
  use ShoppingApp.DataCase

  alias ShoppingApp.Shopping

  describe "lists" do
    alias ShoppingApp.Shopping.List

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def list_fixture(attrs \\ %{}) do
      {:ok, list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shopping.create_list()

      list
    end

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert Shopping.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture()
      assert Shopping.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      assert {:ok, %List{} = list} = Shopping.create_list(@valid_attrs)
      assert list.name == "some name"
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shopping.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      assert {:ok, list} = Shopping.update_list(list, @update_attrs)
      assert %List{} = list
      assert list.name == "some updated name"
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture()
      assert {:error, %Ecto.Changeset{}} = Shopping.update_list(list, @invalid_attrs)
      assert list == Shopping.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture()
      assert {:ok, %List{}} = Shopping.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Shopping.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = Shopping.change_list(list)
    end
  end

  describe "items" do
    alias ShoppingApp.Shopping.Item

    @valid_attrs %{item_type: "some item_type", name: "some name", price: "some price", repeat: true}
    @update_attrs %{item_type: "some updated item_type", name: "some updated name", price: "some updated price", repeat: false}
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
      assert item.repeat == true
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
      assert item.repeat == false
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
