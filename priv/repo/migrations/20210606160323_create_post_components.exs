defmodule Cms.Repo.Migrations.CreatePostComponents do
  use Ecto.Migration

  def change do
    create table(:post_components) do
      add :data, :map
      add :index, :integer
      add :type, :string

      add :post_id, references(:posts, on_delete: :nothing)

      timestamps()
    end

    create index(:post_components, [:post_id])
  end
end
