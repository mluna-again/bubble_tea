defmodule BubbleTea.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
      add :over, :boolean, default: false, null: false

      timestamps()
    end
  end
end
