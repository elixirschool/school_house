defmodule SchoolHouseWeb.Router do
  use SchoolHouseWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SchoolHouseWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SchoolHouseWeb.RedirectPlug
    plug SchoolHouseWeb.SetLocalePlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SchoolHouseWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/blog", PostController, :index
    get "/blog/:slug", PostController, :show
    get "/blog/tag/:tag", PostController, :filter_by_tag

    get "/privacy", PageController, :privacy

    scope "/:locale" do
      get "/", PageController, :index
      get "/why", PageController, :why
      get "/get_involved", PageController, :get_involved
      get "/podcasts", PageController, :podcasts
      live "/conferences", ConferencesLive

      get "/report", ReportController, :index

      get "/lessons/:section", LessonController, :index
      get "/lessons/:section/:name", LessonController, :lesson
    end
  end
end
