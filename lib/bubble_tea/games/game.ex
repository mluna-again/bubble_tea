defmodule BubbleTea.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :name, :string
    field :over, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :over])
    |> validate_required([:name])
    |> validate_length(:name, min: 4)
  end
end
