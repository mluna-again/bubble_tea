defmodule BubbleTea.Games.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :selection, :integer
    field :username, :string
    field :active, :boolean, default: true
    field :game_id, :id

    timestamps()
  end

  @doc false
  def create_changeset(player, attrs) do
    player
    |> cast(attrs, [:username, :game_id])
    |> validate_required([:username])
  end

  @doc false
  def update_changeset(player, attrs) do
    player
    |> cast(attrs, [:username, :selection, :active])
  end
end
