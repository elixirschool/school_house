defmodule SchoolHouseWeb.LessonView do
  use SchoolHouseWeb, :view
  use Phoenix.Component

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

  def render("_section_header.html", assigns) do
    ~H"""
    <.section_header name={@name} header={@header} fragment={@fragment} />
    """
  end

  attr :name, :string, required: true
  attr :header, :string, required: true
  attr :fragment, :string, required: true

  def section_header(assigns) do
    ~H"""
    <div class="group">
      <%= content_tag(@header, id: @fragment, class: "group") do %>
        <%= @name %>
        <a href={"##{@fragment}"} class="ml-2 opacity-0 group-hover:opacity-100 transition-opacity">
          <i class="fas fa-link text-sm"></i>
        </a>
      <% end %>
    </div>
    """
  end
end
