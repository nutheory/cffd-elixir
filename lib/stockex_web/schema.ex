defmodule StockexWeb.Schema do
  use Absinthe.Schema
  import_types StockexWeb.Schema.Types

  query do
    field :fetch_stock, list_of(:stock) do
      arg(:input, :GetStock)
      resolve &StockexWeb.Resolvers.Stock.find/2
    end
  end

end
