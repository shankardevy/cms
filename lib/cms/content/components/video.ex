defmodule Cms.Content.Components.Video do
  use Ecto.Schema

  embedded_schema do
    field :title, :string
    field :url, :string
    field :caption, :string
    field :path, :string
    field :type, :string, default: "video"
  end
end
