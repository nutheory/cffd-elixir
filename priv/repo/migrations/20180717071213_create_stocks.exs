defmodule Stockex.Repo.Migrations.CreateStocks do
  use Ecto.Migration

  def change do
    create table(:stocks) do
      add :name, :string

      timestamps()
    end

  end
end
