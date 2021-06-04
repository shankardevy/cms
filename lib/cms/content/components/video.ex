defmodule Cms.Content.Components.Video do
  @derive Jason.Encoder

  defstruct title: "", url: "", caption: "", path: "", type: "video"
end
