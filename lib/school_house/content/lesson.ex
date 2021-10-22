defmodule SchoolHouse.Content.Lesson do
  @moduledoc """
  Encapsulates an individual lesson and handles parsing the originating markdown file
  """

  @headers_regex ~r/<(h\d)>(["\p{L}\p{M}\s?!\.\/\d]+)(<\/\1>)/iu
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
      excerpt: convert_meta(attrs.excerpt, "excerpt"),
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

    replace_counted(@headers_regex, body, fn _, header, name, _, count ->
      fragment = link_fragment(name, count)

      Phoenix.View.render_to_string(SchoolHouseWeb.LessonView, "_section_header.html",
        fragment: fragment,
        header: header,
        name: name
      )
    end)

  end

  defp link_fragment(name, index) do
    name =
      name
      |> String.trim()
      |> String.downcase()

    name
    |> String.replace(~r/[^\p{L}\s]/u, "")
    |> String.replace(" ", "-")
    |> Kernel.<>("-#{index}")
  end

  defp page_link(name, index) do
    "<a href=\"##{link_fragment(name, index)}\">#{name}</a>"
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

  defp build_table([{size, name, index} | matches], acc) do
    {children, remaining} = Enum.split_while(matches, fn {s, _, _} -> s > size end)
    children = build_table(children)

    section_link =
      name
      |> String.trim()
      |> page_link(index)

    build_table(remaining, ["<li>#{section_link}#{children}</li>" | acc])
  end

  defp table_of_contents_html(body) do
    @headers_regex
    |> Regex.scan(body)
    |> Enum.with_index()
    |> Enum.map(fn {[_, "h" <> size, name, _], index} -> {String.to_integer(size), String.trim(name), index} end)
    |> build_table()
    |> String.replace_leading("<ul", "<ul class=\"table_of_contents\"")
  end

  defp convert_meta("", _) do
    nil
  end

  defp convert_meta(metadata, class) do
    Earmark.as_html!("#{metadata} {: .#{class} }")
  end

  # Replaces regex matches by calling replacement with the match and current match count
  def replace_counted(regex, input, replacement) do
    replace_counted_helper(regex, "", input, replacement, 0)
  end

  # If nothing has changed end recursion
  defp replace_counted_helper(_, prev, prev, _, _) do
    prev
  end

  # If something has changed, replace and recurse
  defp replace_counted_helper(regex, _prev, input, replacement, counter) do
    # Bind the current value of counter for the call to replacement
    replace_wrapper = fn m1, m2, m3, m4 ->
      replacement.(m1, m2, m3, m4, counter)
    end
    new = Regex.replace(regex, input, replace_wrapper, global: false)
    replace_counted_helper(regex, input, new, replacement, counter + 1)
  end
end
