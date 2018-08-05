defmodule StockexWeb.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Stockex.Repo

  object :stock do
    field :id, :id
    field :name, :string
    field :adjustments, list_of(:adjustments)
  end

  input_object :GetStock do
    field :name, :string
    field :date, :string
  end

  input_object :input do
    field :GetStock, :GetStock
  end

  object :adjustments do
    field :date, :string
    field :adj_open, :float
    field :high_low_percent, :float
    field :percent_change, :float
    field :adj_high, :float
    field :adj_low, :float
    field :adj_close, :float
    field :adj_volume, :float
  end
end
