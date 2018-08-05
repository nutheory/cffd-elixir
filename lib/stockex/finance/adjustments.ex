defmodule Stockex.Finance.Adjustments do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :date, :string
    field :percent_change, :float
    field :high_low_percent, :float
    field :adj_open, :float
    field :adj_high, :float
    field :adj_low, :float
    field :adj_close, :float
    field :adj_volume, :float

  end


  def changeset(struct, data) do
    struct |> cast(data, [ :date, :adj_open, :adj_high, :adj_low, :adj_close,
      :adj_volume, :percent_change, :high_low_percent ])
    # |> IO.inspect
  end

end
