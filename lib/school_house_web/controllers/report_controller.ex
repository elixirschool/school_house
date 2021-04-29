defmodule SchoolHouseWeb.ReportController do
  use SchoolHouseWeb, :controller

  alias SchoolHouse.Lessons

  def index(conn, %{"locale" => locale}) do
    render(conn, "report.html", report: Lessons.translation_report(locale))
  end
end
