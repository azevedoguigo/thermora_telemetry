defmodule ThermoraTelemetryWeb.Router do
  use ThermoraTelemetryWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ThermoraTelemetryWeb do
    pipe_through :api
  end
end
