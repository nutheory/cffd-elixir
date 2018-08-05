defmodule Stockex.Finance.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :name, :string
    field :date, :string
    embeds_many :adjustments, Stockex.Finance.Adjustments
    # timestamps()
  end

  def regression(%{ name: name, date: date }) do
    IO.inspect(name)
    IO.inspect(date)
    {:ok, pool} = Piton.Pool.start_link([module: Stockex.Finance.GenPythonPool, pool_number: 1], [])
    IO.inspect(pool)
    {:ok, res} = Piton.Pool.execute(pool, :reg, [name])
    data = Poison.decode!(res)
    IO.inspect(data)
  end

  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:name])
  end
end
