defmodule BubbleTeaWeb.GameLive.Index do
  use BubbleTeaWeb, :live_view

  alias BubbleTea.Games
  alias BubbleTea.Games.Game

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:changeset, Games.change_game(%Game{}))
      |> assign(:game, %Game{})

    {:ok, socket}
  end

  @impl true
  def update(%{game: game} = assigns, socket) do
    changeset = Games.change_game(game)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"game" => game_params}, socket) do
    changeset =
      socket.assigns.game
      |> Games.change_game(game_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"game" => game_params}, socket) do
    case Games.create_game(game_params) do
      {:ok, game} -> {:noreply, redirect(socket, to: "/games/#{game.id}")}
      {:error, changeset} -> {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
