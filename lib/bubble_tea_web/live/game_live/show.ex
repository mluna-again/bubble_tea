defmodule BubbleTeaWeb.GameLive.Show do
  use BubbleTeaWeb, :live_view

  alias BubbleTea.Games
  alias BubbleTea.Games.{Game, Player}

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    socket =
      socket
      |> assign(:game, Games.get_game!(id))
      |> assign(:player, %Player{})
      |> assign(:changeset, Games.change_player(%Player{}))

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", %{"player" => player}, socket) do
    changeset =
      socket.assigns.player
      |> Games.change_player(player)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("new_player", %{player: player}, socket) do
    
        # game = socket.assigns.game
        # socket =
        #   socket
        #   |> assign(:changeset, nil)
        #   |> assign(:player, player)
        #   |> assign(:game, Map.put(game, :players, [player | game.players]))
  end

  def handle_event("save", %{"player" => player}, socket) do
    case Games.attach_player(socket.assigns.game, player) do
      {:ok, player} ->
        socket =
          socket
          |> assign(:changeset, nil)
          |> assign(:player, player)

        # BubbleTeaWeb.Endpoint.broadcast(socket, "new_player", %{player: player})
        IO.inspect(Map.keys(socket))
        {:noreply, socket}
      {:error, changeset} -> {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
