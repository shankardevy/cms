defmodule Cms.Content.Components.Gallery do

  @derive Jason.Encoder
  defstruct title: "", alt_text: "", description: "", caption: "", path: "", type: "image"
end
