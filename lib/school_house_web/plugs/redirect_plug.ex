defmodule SchoolHouseWeb.RedirectPlug do
  @moduledoc """
  Handle redirecting users based on a collection of patterns
  """
  import Plug.Conn

  require Logger

  @redirects Application.compile_env!(:school_house, :redirects)

  @spec init(any) :: any
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(conn, _opts) do
    redirect_to = redirect_to_path(conn)

    if is_nil(redirect_to) do
      conn
    else
      Logger.debug("Redirect from #{conn.request_path} to #{redirect_to}")

      conn
      |> Phoenix.Controller.redirect(to: redirect_to)
      |> halt()
    end
  end

  defp redirect_to_path(conn) do
    with {pattern, replacement} <- Enum.find(@redirects, &path_matcher(&1, conn.request_path)) do
      Regex.replace(pattern, conn.request_path, replacement)
    end
  end

  defp path_matcher({pattern, _replacement}, request_path), do: Regex.match?(pattern, request_path)
end
