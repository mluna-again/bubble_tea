defmodule BubbleTea.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias BubbleTea.Repo

  alias BubbleTea.Games.{Game, Player}

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    Repo.all(Game)
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id), do: Repo.get!(Game, id) |> Repo.preload([:players])

  def get_game_with_active_users!(id) do
    game = get_game!(id)
    active_players = Enum.filter(game.players, fn player -> player.active end)

    Map.put(game, :players, active_players)
  end

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{data: %Game{}}

  """
  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end

  def change_player(%Player{} = player, attrs \\ %{}) do
    Player.update_changeset(player, attrs)
  end

  def attach_player(%Game{} = game, attrs \\ %{}) do
    player = Repo.get_by(Player, username: attrs["username"]) || %Player{}

    player
    |> Player.create_changeset(Map.put(attrs, "game_id", game.id))
    |> Repo.insert_or_update()
  end

  def get_player!(id), do: Repo.get!(Player, id)

  def detach_player!(%Player{} = player) do
    player
    |> Player.update_changeset(%{active: false})
    |> Repo.update!()
  end
end
