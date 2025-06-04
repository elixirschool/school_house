defmodule SchoolHouse.LocalesTest do
  use ExUnit.Case

  alias SchoolHouse.LocaleInfo

  test "Locales in LocaleInfo are same as in config" do
    assert LocaleInfo.list() == Application.get_env(:school_house, SchoolHouseWeb.Gettext)[:locales]
  end
end
