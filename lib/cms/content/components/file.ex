defmodule Cms.Content.Components.File do
  @derive Jason.Encoder

  defstruct title: "", description: "", caption: "", path: "", type: "file"
end
