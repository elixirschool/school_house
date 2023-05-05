defmodule SchoolHouseWeb.LessonView do
  use SchoolHouseWeb, :view
  import Phoenix.Component, only: [sigil_H: 2]

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
