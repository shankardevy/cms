defmodule Cms.Contents.Component do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cms.Contents.Post

  schema "post_components" do
    field :data, :map
    field :index, :integer
    field :type, :string
    field :delete, :boolean, virtual: true
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(component, attrs) do
    component
    |> cast(attrs, [:data, :type, :index])
    |> validate_required([:post_id, :type, :index])
  end
end
