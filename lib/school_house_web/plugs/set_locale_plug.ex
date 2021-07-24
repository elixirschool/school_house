defmodule SchoolHouseWeb.SetLocalePlug do
  @moduledoc """
  Set the process' locale given the path params value
  """

  import Phoenix.Controller, only: [redirect: 2]
  import Plug.Conn, only: [halt: 1]

  @spec init(any) :: any
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(conn, _opts) do
    locale = Map.get(conn.path_params, "locale", default_locale())

    case valid_locale?(locale) do
      true ->
        Gettext.put_locale(SchoolHouseWeb.Gettext, locale)
        conn

      false ->
        redirect(conn, to: "/") |> halt()
    end
  end

  defp valid_locale?(locale) do
    Enum.member?(valid_locales(), locale)
  end

  defp default_locale do
    locale_config(:default_locale)
  end

  defp valid_locales do
    locale_config(:locales)
  end

  defp locale_config(key) do
    :school_house
    |> Application.get_env(SchoolHouseWeb.Gettext)
    |> Keyword.get(key)
  end
end
