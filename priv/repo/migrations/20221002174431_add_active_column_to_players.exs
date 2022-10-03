defmodule BubbleTea.Repo.Migrations.AddActiveColumnToPlayers do
  use Ecto.Migration

  def change do
    alter table(:players) do
      add :active, :boolean, default: true
    end
  end
end
