defmodule Cms.Content.Components.CTA do
  use Ecto.Schema

  @derive Jason.Encoder
  embedded_schema do
    field :line1, :string
    field :line2, :string
    field :description, :string
    field :primary_action_name, :string
    field :primary_action_url, :string
    field :secondary_action_name, :string
    field :secondary_action_url, :string

    field :type, :string, default: "cta"
  end
end
