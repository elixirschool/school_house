defmodule SchoolHouseWeb.Components do
  use Phoenix.Component

  def app(assigns) do
    ~H"""
    <div class="min-h-screen">
      <header>
        <!-- Your header content -->
      </header>

      <main class="container mx-auto mt-28 px-5 flex">
        <%= @inner_content %>
      </main>
    </div>
    """
  end
end
