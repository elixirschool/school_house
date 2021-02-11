defmodule SchoolHouse.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :school_house,
    adapter: Ecto.Adapters.Postgres
end
