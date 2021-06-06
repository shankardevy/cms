defmodule Page.TextComponent do
  use CmsWeb, :live_component

  defstruct text: "", type: "", format: ""

  def render(assigns) do
    ~L"""
      <div class="prose">
        <%= raw(@component.data["text"]) %>
      </div>
    """
  end

  defmodule Form do
    use CmsWeb, :live_component

    def render(assigns) do
      ~L"""
      <div class="sm:col-span-4">
        <label for="about" class="block text-sm font-medium text-gray-700">
          Text
        </label>
        <div phx-hook="QuillEditor" id="editor-#{@component_form.index}" class="mt-1">
          <input type="hidden" name="<%= @component_form.name %>[data][type]" value="text" />
          <div class="quill-editor"><%= raw(@component.text) %></div>
          <input class="content" type="hidden" name="<%= @component_form.name %>[data][text]" value="<%= @component.text %>" />
        </div>
      </div>
      """
    end
  end
end
