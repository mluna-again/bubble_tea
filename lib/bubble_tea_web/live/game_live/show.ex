defmodule BubbleTeaWeb.GameLive.Show do
  use BubbleTeaWeb, :live_view

  alias BubbleTea.Games

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    socket = assign(socket, :game, Games.get_game!(id))
    {:ok, socket}
  end
end
