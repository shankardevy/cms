defmodule Cms.Content.Component do
  use Ecto.Schema

  embedded_schema do
    field :data, Cms.Content.ComponentData
  end
end
