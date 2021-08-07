defmodule SchoolHouse.Content.Lesson do
  @moduledoc """
  Encapsulates an individual lesson and handles parsing the originating markdown file
  """

  @headers_regex ~r/<(h\d)>(["\p{L}\s?!\.\/\d]+)(?=<\/\1>)/iu
  @enforce_keys [:body, :section, :locale, :name, :title, :version]

  defstruct [
    :body,
    :excerpt,
    :locale,
    :name,
    :next,
    :previous,
    :redirect_from,
    :section,
    :table_of_contents,
    :title,
    :version
  ]

  def build(filename, attrs, body) do
    [locale, section, name] =
      filename
      |> Path.rootname()
      |> Path.split()
      |> Enum.take(-3)

    filename_attrs = [
      body: add_table_of_contents_links(body),
      locale: locale,
      name: String.to_atom(name),
      section: String.to_atom(section),
      table_of_contents: table_of_contents_html(body),
      version: parse_version(attrs.version)
    ]

    struct!(__MODULE__, Map.to_list(attrs) ++ filename_attrs)
  end

  defp add_table_of_contents_links(body) do
    toc_html = table_of_contents_html(body)

    body = String.replace(body, "{% include toc.html %}", toc_html)

    Regex.replace(@headers_regex, body, fn _, header, name, _ ->
      fragment = link_fragment(name)

      Phoenix.View.render_to_string(SchoolHouseWeb.LessonView, "_section_header.html",
        fragment: fragment,
        header: header,
        name: name
      )
    end)
  end

  defp link_fragment(name) do
    name =
      name
      |> String.trim()
      |> String.downcase()

    name
    |> String.replace(~r/[^\p{L}\s]/u, "")
    |> String.replace(" ", "-")
  end

  defp page_link(name) do
    "<a href=\"##{link_fragment(name)}\">#{name}</a>"
  end

  defp parse_version(string) do
    [major, minor, patch] =
      string
      |> String.split(".")
      |> Enum.map(&String.to_integer/1)

    {major, minor, patch}
  end

  defp build_table(matches, acc \\ [])

  defp build_table([], []) do
    ""
  end

  defp build_table([], acc) do
    "<ul>#{acc |> Enum.reverse() |> Enum.join("")}</ul>"
  end

  defp build_table([{size, name} | matches], acc) do
    {children, remaining} = Enum.split_while(matches, fn {s, _} -> s > size end)
    children = build_table(children)

    section_link =
      name
      |> String.trim()
      |> page_link()

    build_table(remaining, ["<li>#{section_link}#{children}</li>" | acc])
  end

  defp table_of_contents_html(body) do
    @headers_regex
    |> Regex.scan(body)
    |> Enum.map(fn [_, "h" <> size, name] -> {String.to_integer(size), String.trim(name)} end)
    |> build_table()
    |> String.replace_leading("<ul", "<ul class=\"table_of_contents\"")
  end
end
