defmodule Cms.Content.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :title, :string
    embeds_many :components, Cms.Content.Component

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :components])
    |> validate_required([:title, :components])
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
