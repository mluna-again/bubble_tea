defmodule BubbleTea.Repo do
  use Ecto.Repo,
    otp_app: :bubble_tea,
    adapter: Ecto.Adapters.Postgres
end
