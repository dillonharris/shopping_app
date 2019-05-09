defmodule ShoppingApp.AccountsTest do
  use ShoppingApp.DataCase

  alias ShoppingApp.Accounts

  describe "users" do
    alias ShoppingApp.Accounts.User

    @valid_attrs %{email: "email@example.com", is_active: true, password: "some password"}
    @update_attrs %{
      email: "email@example.com",
      is_active: false,
      password: "some updated password"
    }
    @invalid_attrs %{email: nil, is_active: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      _user =
        Repo.get!(
          from(u in User,
            preload: [:lists, :items]
          ),
          user.id
        )
    end

    test "list_users/0 returns all users" do
      user = user_fixture()

      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "email@example.com"
      assert user.is_active == true
      assert user.password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "email@example.com"
      assert user.is_active == false
      assert user.password == "some updated password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
