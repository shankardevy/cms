defmodule Cms.Content.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :title, :string
    embeds_many :components, Cms.Content.Component, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> cast_embed(:components)
  end
end

# %Article{
#   title: "test",
#   components: [
#     %{
#       data: %{type: "cta"}
#     },
#     %{
#       data: %{type: "image"}
#     },
#     %{
#       data: %{type: "text"}
#     }
#   ]
# }
