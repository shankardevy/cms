defmodule Cms.Content.Components.File do
  use Ecto.Schema

  embedded_schema do
    field :title, :string
    field :description, :string
    field :caption, :string
    field :path, :string
    field :type, :string, default: "file"
  end
end
