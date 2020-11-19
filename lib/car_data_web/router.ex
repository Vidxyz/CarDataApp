defmodule CarDataWeb.Router do
  use CarDataWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
  end

  scope "/", CarDataWeb do
    pipe_through :browser

    get "/", VehicleController, :index
  end

  scope "/api" do
    pipe_through :api

    scope "/graphql" do
      forward "/graphiql", Absinthe.Plug.GraphiQL, schema: CarDataWeb.Schema
      forward "/", Absinthe.Plug, schema: CarDataWeb.Schema
    end

    scope "/vehicle" do
      get "/image", CarDataWeb.VehicleController, :show_image
    end
  end




end
