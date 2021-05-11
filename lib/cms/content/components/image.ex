defmodule Cms.Content.Components.Image do
  use Ecto.Schema

  embedded_schema do
    field :title, :string
    field :alt_text, :string
    field :description, :string
    field :caption, :string
    field :path, :string
    field :type, :string, default: "image"
  end
end
