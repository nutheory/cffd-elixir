defmodule StockexWeb.Router do
  use StockexWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/api", StockexWeb do
  #   pipe_through :api
  # end


  forward "/api", Absinthe.Plug, schema: StockexWeb.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: StockexWeb.Schema
end
