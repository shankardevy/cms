defmodule Cms.Content.Components.Text do
  @derive Jason.Encoder

  defstruct text: "", type: "", format: ""
end
