defmodule Cms.Contents.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cms.Contents.Component
  schema "posts" do
    field :title, :string
    has_many :components, Component
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
