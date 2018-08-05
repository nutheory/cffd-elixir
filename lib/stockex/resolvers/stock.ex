defmodule StockexWeb.Resolvers.Stock do

  alias Stockex.Finance

  def find(%{ input: %{name: name, date: date } }, _info) do
    {:ok, Finance.get_stock(%{name: name, date: date})}
  end

end
