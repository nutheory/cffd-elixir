# defmodule StockexWeb.StockController do
#   use StockexWeb, :controller

#   alias Stockex.Finance
#   alias Stockex.Finance.Stock

#   action_fallback StockexWeb.FallbackController

#   def index(conn, _params) do
#     stocks = Finance.list_stocks()
#     render(conn, "index.json", stocks: stocks)
#   end

#   def create(conn, %{"stock" => stock_params}) do
#     with {:ok, %Stock{} = stock} <- Finance.create_stock(stock_params) do
#       conn
#       |> put_status(:created)
#       |> put_resp_header("location", stock_path(conn, :show, stock))
#       |> render("show.json", stock: stock)
#     end
#   end

#   def show(conn, %{"id" => id}) do
#     stock = Finance.get_stock!(id)
#     render(conn, "show.json", stock: stock)
#   end

#   def update(conn, %{"id" => id, "stock" => stock_params}) do
#     stock = Finance.get_stock!(id)

#     with {:ok, %Stock{} = stock} <- Finance.update_stock(stock, stock_params) do
#       render(conn, "show.json", stock: stock)
#     end
#   end

#   def delete(conn, %{"id" => id}) do
#     stock = Finance.get_stock!(id)
#     with {:ok, %Stock{}} <- Finance.delete_stock(stock) do
#       send_resp(conn, :no_content, "")
#     end
#   end
# end
