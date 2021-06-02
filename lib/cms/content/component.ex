defmodule Cms.Content.Component do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :data, :map
  end

  def changeset(component, attrs) do
    component
    |> cast(attrs, [:id, :data])
    |> validate_required([:data])
  end

end
