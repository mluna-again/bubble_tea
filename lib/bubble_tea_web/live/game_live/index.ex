defmodule BubbleTeaWeb.GameLive.Index do
  use BubbleTeaWeb, :live_view

  alias BubbleTea.Games
  alias BubbleTea.Games.Game

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
