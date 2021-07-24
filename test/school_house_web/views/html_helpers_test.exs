defmodule SchoolHouseWeb.HtmlHelpersTest do
  use SchoolHouseWeb.ConnCase

  alias SchoolHouseWeb.HtmlHelpers

  setup do
    Gettext.put_locale("es")

    on_exit(fn ->
      Gettext.put_locale("en")
    end)
  end

  describe "avatar_url/1" do
    test "appends .png to GitHub profile link" do
      assert "https://github.com/elixirschool.png" == HtmlHelpers.avatar_url("https://github.com/elixirschool")
    end
  end

  describe "current_locale/0" do
    test "returns the current locale used by Gettext" do
      assert "es" == HtmlHelpers.current_locale()
    end
  end

  describe "current_page_locale_path/2" do
    test "returns the current page path for another locale" do
      assert "/fr/ecto/changesets" ==
               :get
               |> build_conn("/es/ecto/changesets")
               |> HtmlHelpers.current_page_locale_path("fr")
    end

    test "returns the home page path for another locale" do
      assert "/fr" ==
               :get
               |> build_conn("/es")
               |> HtmlHelpers.current_page_locale_path("fr")
    end

    test "returns the same page path for a page without locale scope" do
      assert "/blog/instrumenting-phoenix" ==
               :get
               |> build_conn("/blog/instrumenting-phoenix")
               |> HtmlHelpers.current_page_locale_path("fr")
    end

    test "doesn't break URLs starting with something similar to a locale" do
      assert "/essential" ==
               :get
               |> build_conn("/essential")
               |> HtmlHelpers.current_page_locale_path("ar")
    end
  end

  describe "supported_locales/0" do
    test "returns a list of all supported locales" do
      locales = HtmlHelpers.supported_locales()

      assert is_list(locales)
      assert 1 < length(locales)
    end
  end
end
