defmodule Cms.Content.Component do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :data, :map
    field :index, :integer, default: 0
    field :delete, :boolean
  end

  def changeset(component, attrs) do
    component
    |> cast(attrs, [:id, :data])
    |> validate_required([:data])
    |> may_be_delete(attrs)
  end

  def set_for_deletion(changeset) do
    may_be_delete(changeset, %{"delete" => "true"})
    |> put_change(:delete, true)
  end

  def may_be_delete(changeset, %{"delete" => "true"}) do
    %{changeset | action: :delete}
  end

  def may_be_delete(changeset, _), do: changeset
end
