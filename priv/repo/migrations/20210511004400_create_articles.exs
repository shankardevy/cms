defmodule Cms.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :components, {:array, :map}

      timestamps()
    end

  end
end
