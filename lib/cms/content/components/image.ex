defmodule Cms.Content.Components.Image do
  @derive Jason.Encoder

  defstruct title: "", alt_text: "", description: "", caption: "", path: "", type: "image"
end
