defmodule ThermoraTelemetry.Repo do
  use Ecto.Repo,
    otp_app: :thermora_telemetry,
    adapter: Ecto.Adapters.Postgres
end
