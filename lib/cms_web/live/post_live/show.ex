defmodule CmsWeb.PostLive.Show do
  use CmsWeb, :live_view

  alias Cms.Contents

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:post, Contents.get_post!(id))}
  end

  defp enabled_components do
    [
      %{type: "Page.Component.Text", title: "Text"},
      %{type: "Page.Component.Image", title: "Image"}
    ]
  end

  def render_component(socket, component) do
    component_type = String.to_existing_atom("Elixir." <> component.type)

    live_component(socket, component_type, id: component.id, data: component)
  end

end
