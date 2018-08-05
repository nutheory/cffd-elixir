defmodule Stockex.Finance.StockElixir do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :name, :string
    embeds_many :adjustments, Stockex.Finance.Adjustments
    # timestamps()
  end

  def from_json(%{ name: name, data: data }) when is_binary(data) do
    Poison.decode!(data) |> Map.get("dataset_data") |> Map.put("name", name) |> from_json
  end
  def from_json(data) when is_map(data) do
    names = Map.get(data, "column_names")
    |> Enum.map(fn key -> String.downcase(key) |> String.replace(~r/(-|\s+)/, "_")
      |> String.replace(~r/\./, "") |> String.to_atom()
    end)

    data_list = Map.get(data, "data")
    |> Enum.map(fn dt -> Enum.zip(names, dt)
      |> Enum.into(%{}) |> percent_change |> high_low_percent
    end)

    %__MODULE__{}
    |> cast(%{adjustments: data_list, name: Map.get(data, "name")}, [:name])
    |> cast_embed(:adjustments)
    |> apply_changes
  end


  def high_low_percent(data) do
    hl =(data.adj_high - data.adj_close) / data.adj_close * 100.0
    Map.merge(data, %{high_low_percent: hl})
  end

  def percent_change(data) do
    per = (data.adj_close - data.adj_open) / data.adj_open * 100.0
    Map.merge(data, %{percent_change: per})
  end

  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:name])
  end
end
