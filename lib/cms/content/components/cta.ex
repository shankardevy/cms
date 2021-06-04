defmodule Cms.Content.Components.CTA do
  @derive Jason.Encoder

  defstruct line1: "", line2: "", description: "", primary_action_name: "", primary_action_url: "", secondary_action_name: "", secondary_action_url: "", type: "cta"
end
