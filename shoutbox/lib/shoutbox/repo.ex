defmodule Shoutbox.Repo do
  use Ecto.Repo,
    otp_app: :shoutbox,
    adapter: Ecto.Adapters.Postgres
end
