defmodule SchoolHouseWeb.SetLocalePlug do
  @moduledoc """
  Set the process' locale given the path params value
  """

  @spec init(any) :: any
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(conn, _opts) do
    locale = Map.get(conn.path_params, "locale", default_locale())
    Gettext.put_locale(SchoolHouseWeb.Gettext, locale)

    conn
  end

  defp default_locale do
    :school_house
    |> Application.get_env(SchoolHouseWeb.Gettext)
    |> Keyword.get(:default_locale)
  end
end
