defmodule SchoolHouseWeb.ErrorView do
  use SchoolHouseWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  def render("404.html", %{translation_not_found: true}) do
    "Translation Not Found — CTA here"
  end

  def render("404.html", _assigns) do
    "Not Found"
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
