defmodule SchoolHouse.Content.Post do
  @moduledoc """
  The data representation of a post
  """

  @enforce_keys [:body, :name, :title]
  defstruct [
    :body,
    :name,
    :title
  ]

  def build(filename, attrs, body) do
    [locale, section, name] =
      filename
      |> Path.rootname()
      |> Path.split()
      |> Enum.take(-3)

    filename_attrs = [
      body: body,
      name: String.to_atom(name)
    ]

    struct!(__MODULE__, filename_attrs ++ Map.to_list(attrs))
  end
end
