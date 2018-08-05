defmodule Stockex.FinanceTest do
  use Stockex.DataCase

  alias Stockex.Finance

  describe "stocks" do
    alias Stockex.Finance.Stock

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def stock_fixture(attrs \\ %{}) do
      {:ok, stock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Finance.create_stock()

      stock
    end

    test "list_stocks/0 returns all stocks" do
      stock = stock_fixture()
      assert Finance.list_stocks() == [stock]
    end

    test "get_stock!/1 returns the stock with given id" do
      stock = stock_fixture()
      assert Finance.get_stock!(stock.id) == stock
    end

    test "create_stock/1 with valid data creates a stock" do
      assert {:ok, %Stock{} = stock} = Finance.create_stock(@valid_attrs)
      assert stock.name == "some name"
    end

    test "create_stock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_stock(@invalid_attrs)
    end

    test "update_stock/2 with valid data updates the stock" do
      stock = stock_fixture()
      assert {:ok, stock} = Finance.update_stock(stock, @update_attrs)
      assert %Stock{} = stock
      assert stock.name == "some updated name"
    end

    test "update_stock/2 with invalid data returns error changeset" do
      stock = stock_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_stock(stock, @invalid_attrs)
      assert stock == Finance.get_stock!(stock.id)
    end

    test "delete_stock/1 deletes the stock" do
      stock = stock_fixture()
      assert {:ok, %Stock{}} = Finance.delete_stock(stock)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_stock!(stock.id) end
    end

    test "change_stock/1 returns a stock changeset" do
      stock = stock_fixture()
      assert %Ecto.Changeset{} = Finance.change_stock(stock)
    end
  end
end
