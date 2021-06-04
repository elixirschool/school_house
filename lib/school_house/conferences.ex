defmodule SchoolHouse.Conferences do
  @moduledoc false

  use NimblePublisher,
    build: SchoolHouse.Content.Conference,
    from: Application.compile_env!(:school_house, :conference_dir),
    as: :conferences

  def list, do: @conferences
end
