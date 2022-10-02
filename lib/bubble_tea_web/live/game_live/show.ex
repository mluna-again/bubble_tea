defmodule BubbleTeaWeb.GameLive.Show do
  use BubbleTeaWeb, :live_view

  alias BubbleTea.Games
  alias BubbleTea.Games.{Game, Player}
  alias Phoenix.PubSub

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    game = Games.get_game!(id)
    topic = "games-#{game.id}"
    PubSub.subscribe(BubbleTea.PubSub, topic)

    socket =
      socket
      |> assign(:game, game)
      |> assign(:player, %Player{})
      |> assign(:topic, topic)
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

  def handle_event("save", %{"player" => player}, socket) do
    case Games.attach_player(socket.assigns.game, player) do
      {:ok, player} ->
        socket =
          socket
          |> assign(:changeset, nil)
          |> assign(:player, player)

        PubSub.broadcast!(BubbleTea.PubSub, socket.assigns.topic, %{
          player: player,
          action: "new_player"
        })

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def handle_info(%{player: player, action: "new_player"}, socket) do
    game = socket.assigns.game
    player = Games.get_player!(player.id)

    socket =
      socket
      |> assign(:game, Map.put(game, :players, [player | game.players]))

    {:noreply, socket}
  end
end
