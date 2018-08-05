defmodule Stockex.Finance.Dataframe do
  use Ecto.Schema
  # import Ecto.Changeset
  # import DataFrame
  # frame = DataFrame.new(values, ["Names", "Births"])


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
      |> Enum.into(%{}) |> percent_change
      |> high_low_percent |> cleanse_data |> Enum.unzip() |> elem(1)
    end)

    headers = [:adj_close, :adj_high, :adj_low, :adj_open, :adj_volume, :date,
      :high_low_percent, :percent_change]

    df = DataFrame.new(data_list, 0..(length(data_list)), headers)
    |> DataFrame.head(50)
    # |> DataFrame.fillna(-99999)

    forecast_out = Float.ceil(0.1 * length(df.values))
    new_df = df |> DataFrame.shift(:adj_close, -forecast_out)
    new_df |> DataFrame.fillna(-99999)
  end

  def cleanse_data(data) do
    Map.drop(data, [:open, :high, :low, :close, :volume, :ex_dividend, :split_ratio])
  end

  def high_low_percent(data) do
    hl = (data.adj_high - data.adj_close) / data.adj_close * 100.0
    Map.merge(data, %{high_low_percent: hl})
  end

  def percent_change(data) do
    per = (data.adj_close - data.adj_open) / data.adj_open * 100.0
    Map.merge(data, %{percent_change: per})
  end
end
