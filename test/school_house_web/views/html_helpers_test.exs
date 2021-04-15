defmodule SchoolHouseWeb.HtmlHelpersTest do
  use SchoolHouseWeb.ConnCase

  alias SchoolHouseWeb.HtmlHelpers

  describe "avatar_url/1" do
    test "appends .png to GitHub profile link" do
      assert "https://github.com/elixirschool.png" == HtmlHelpers.avatar_url("https://github.com/elixirschool")
    end
  end

  describe "current_locale/0" do
    setup do
      Gettext.put_locale("es")

      on_exit(fn ->
        Gettext.put_locale("en")
      end)
    end

    test "returns the current locale used by Gettext" do
      assert "es" == HtmlHelpers.current_locale()
    end
  end

  describe "current_page_locale_path/2" do
    setup do
      Gettext.put_locale("es")

      on_exit(fn ->
        Gettext.put_locale("en")
      end)
    end

    test "returns the current page path for another locale" do
      assert "/fr/ecto/changesets" ==
               :get
               |> build_conn("/es/ecto/changesets")
               |> HtmlHelpers.current_page_locale_path("fr")

      # With or without a leading slash, the replacement is correct
      assert "fr/ecto/changesets" ==
               :get
               |> build_conn("es/ecto/changesets")
               |> HtmlHelpers.current_page_locale_path("fr")
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
