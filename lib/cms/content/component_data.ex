defmodule Cms.Content.ComponentData do
  use Ecto.Type

  def type, do: :map

  # Provide custom casting rules.
  def cast(component) do
    load(component)
  end

  # When loading data from the database
  def load(component) do
    type = component["type"]
    struct = case type do
      "cta" -> Cms.Content.Components.CTA
      "gallery" -> Cms.Content.Components.Gallery
      "text" -> Cms.Content.Components.Text
      "image" -> Cms.Content.Components.Image
      "video" -> Cms.Content.Components.Video
      "file" -> Cms.Content.Components.File
    end

    data =  component |> Map.new(fn {k, v} ->
      # k = case is_atom(k) do
      #   true -> k
      #   false -> String.to_atom(k)
      # end
      {String.to_atom(k), v}
    end)

    component = struct!(struct, data)

    {:ok, component}
  end

  # When dumping data to the database
  def dump(component) when is_struct(component), do: {:ok, Map.from_struct(component)}
  def dump(component) when is_map(component), do: {:ok, component}

end
