defmodule SchoolHouseWeb.ErrorView do
  use SchoolHouseWeb, :view

  def render("404.html", assigns) do
    render("error.html",
      conn: assigns.conn,
      title: "Page not found",
      message: "The page you're looking for seems to be missing."
    )
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, assigns) do
    title = Phoenix.Controller.status_message_from_template(template)

    render("error.html",
      conn: assigns.conn,
      title: title,
      message: "An error occurred."
    )
  end
end
