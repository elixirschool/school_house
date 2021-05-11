defmodule SchoolHouse.Podcasts do
  @moduledoc false

  use NimblePublisher,
    build: SchoolHouse.Content.Podcast,
    from: Application.compile_env!(:school_house, :podcast_dir),
    as: :podcasts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  def list, do: @podcasts
end
