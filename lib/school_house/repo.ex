defmodule SchoolHouse.Repo do
  use Ecto.Repo,
    otp_app: :school_house,
    adapter: Ecto.Adapters.Postgres
end
