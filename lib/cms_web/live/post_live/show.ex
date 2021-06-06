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

end
