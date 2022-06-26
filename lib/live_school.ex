#!/usr/bin/env elixir

defmodule LiveSchool do
  @moduledoc """
  LiveSchool converts school lessons to LiveBook notebooks!

  """


  def rewrite_expre(code) do
    is_iex = fn x -> String.match?(x, ~r/^iex>/) end
    write_cells = fn code -> "\n```elixir\n" <> code <> "```\n" end
    strip_iex = fn x -> String.slice(x, 4..-1//1) end

    if Enum.any?(code, is_iex) do
      code
      |> Enum.filter(is_iex)
      |> Enum.map(strip_iex)
      |> Enum.map(write_cells)
      |> Enum.join()
    else
      "\n```elixir\n" <> Enum.join(code) <> "```\n"
    end
  end
 
  defp local_cats_only(ast) do
     ast 
     |> Macro.prewalk(fn
         danger = {{:., _, _}, _, _} ->
           IO.puts("warning: removed non local call to #inspect(danger)}")
           nil

         {:eval, _, args} when is_list(args) ->
           IO.puts("warning: removed call to eval")
           nil

         code -> code
        end)
  end


  defp kernel_only(ast) do
    quote do
      import Kernel, only: [sigil_D: 2]
      unquote(ast)
    end
  end

  defp safer_eval(danger) do
   {value, _} = 
         danger 
         |> Code.string_to_quoted!()  
         |> local_cats_only
         |> kernel_only
         |> Code.eval_quoted

    value
  end

  def split_at(array, string) do
    loc = Enum.find_index(array, fn x -> String.equivalent?(String.trim(x), string) end)

    if is_nil(loc) do
      array
    else
      {head, [_sep | tail]} = Enum.split(array, loc)
      {head, tail}
    end
  end

  def rewrite_title(content) do
    case split_at(content, "---") do
	{code, rest} ->  
	    if String.starts_with?(hd(code), "%{") do
	       info = code |> Enum.join("") |> safer_eval      # nee Code.eval_string()
	       title = Map.get(info, :title, "Untitled") |> IO.inspect
               ["# " <> title <> "\n" | rest]
	    else
	       [ code, "---\n" , rest ]
            end
        single -> single 
    end
  end

  def reschool(pid) when is_pid(pid) do
    pid |> IO.stream(:line) |> reschool()
  end

  def reschool(content) when is_struct(content, File.Stream) do
    content |> Enum.to_list() |> reschool()
  end

  def reschool(content) when is_list(content) do
    content
    |> rewrite_title
    |> Stream.chunk_by(fn x -> String.match?(x, ~r/^```/) end)
    |> Stream.chunk_every(4)
    |> Stream.map(fn
      [pre, ["```elixir\n"], content, ["```\n"]] ->
        [pre, rewrite_expre(content)]
      rest ->
        rest
    end)
    |> Enum.join()
  end

  def reschool_file(filename) when is_binary(filename) do
    stream = File.stream!(filename, [:utf8])
    stream |> reschool()
  end

  def reschool_path!(path) when is_binary(path) do
    files = Path.wildcard(path <> "/**/*\.md")

    res = files |> Enum.map(fn filename ->
      newname = String.trim(filename, ".md") <> ".livemd" 
      IO.write(newname <> " --> ")
      newcontent = reschool_file(filename)
      :ok = File.write(newname, newcontent)
    end)

    pass = Enum.count(res, fn x -> x == :ok end)
    count = Enum.count(res)

    {pass, count}
  end
end

