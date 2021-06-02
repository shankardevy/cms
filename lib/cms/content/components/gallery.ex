defmodule Cms.Content.Components.Gallery do
  use Ecto.Schema

  @derive Jason.Encoder
  embedded_schema do
    field :title, :string
    field :alt_text, :string
    field :description, :string
    field :caption, :string
    field :path, :string
    field :type, :string, default: "image"
  end
end
