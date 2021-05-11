defmodule Cms.Content.Components.Text do
  use Ecto.Schema

  embedded_schema do
    field :text, :string
    field :type, :string, default: "text"
    field :format, Ecto.Enum, values: [:plain, :html, :markdown]
  end
end
