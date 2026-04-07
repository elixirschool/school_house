defmodule SchoolHouseWeb.LessonView do
  use SchoolHouseWeb, :view
  import Phoenix.Component, only: [sigil_H: 2]

  use Gettext, backend: SchoolHouseWeb.Gettext

  @section_names %{
    basics: "Basics",
    intermediate: "Intermediate",
    advanced: "Advanced",
    testing: "Testing",
    data_processing: "Data Processing",
    ecto: "Ecto",
    storage: "Storage",
    misc: "Miscellaneous"
  }

  def section_display_name(section) do
    name = Map.get(@section_names, section, to_string(section))
    Gettext.gettext(SchoolHouseWeb.Gettext, name)
  end

  def fa_locale_styles(assigns) do
    ~H"""
      <style>
        @import url('https://fonts.googleapis.com/css2?family=Vazirmatn:wght@400;700&display=swap');

        html[lang="fa"] {
          font-family: Vazirmatn, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
        }
      </style>
    """
  end
end
