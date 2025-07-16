#!/usr/bin/env elixir

defmodule LiveSchool.Cli do
  @moduledoc """
  synopsis:
    Convert elixir lessons to LiveView notebooks.
  usage:
    $ live_school {options} location
  options:
    --path      Convert an entire path containing .md files, writes .livemd files
    --file      Convet single file to stdout
  """

  def main([help_opt]) when help_opt == "-h" or help_opt == "--help" do
    IO.puts(@moduledoc)
  end

  def main(args) do
    {opts, cmd_and_args, errors} = parse_args(args)

    case errors do
      [] ->
        process_args(opts, cmd_and_args)

      _ ->
        IO.puts("Bad option:")
        IO.inspect(errors)
        IO.puts(@moduledoc)
    end
  end

  defp parse_args(args) do
    {opts, cmd_and_args, errors} =
      args
      |> OptionParser.parse(strict: [help: :boolean, file: :string, path: :string])

    {opts, cmd_and_args, errors}
  end

  defp process_args(opts, _args) do
    path_spec = Keyword.has_key?(opts, :path)
    file_spec = Keyword.has_key?(opts, :file)

    if (file_spec and path_spec) or
         !(file_spec or path_spec) do
      {nil, nil, "Must specify either a path or a file"}
    else
      cond do
        file_spec ->
          file = opts[:file]

          if File.regular?(file) do
            IO.write(LiveSchool.reschool_file(file))
          else
            IO.puts("Regular file not found: " <> file)
          end

        path_spec ->
          path = opts[:path]

          if File.dir?(path) do
            {success, total} = LiveSchool.reschool_path!(path)
            IO.puts("#{success} / #{total}  successfully converted")
          else
            IO.puts("Directory not found: " <> path)
          end
      end
    end
  end
end
