defmodule CmsWeb.ArticleLive.SectionComponent do
  use CmsWeb, :live_component

  def ensure_component(component) when is_struct(component), do: component
  def ensure_component(map) when is_map(map) do
    {:ok, component} = Cms.Content.ComponentData.load(map)
    component
  end

  def render(assigns) do
    ~L"""
    <div class="group mt-4 relative">
      <%= hidden_inputs_for(@component_form) %>
      <input type="hidden" name="<%= @component_form.name %>[delete]" value="<%= input_value(@component_form, :delete) %>" />
      <% component = ensure_component(input_value(@component_form, :data)) %>
      <div class="mb-1 flex items-center justify-end opacity-0 group-hover:opacity-80 focus-within:opacity-80">
        <div class="absolute z-10 flex items-center justify-end space-x-2 right-0 top-0" data-element="actions">
          <span class="tooltip top cursor-pointer" aria-label="Edit content" data-element="enable-insert-mode-button">
            <div class="icon-button">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z" />
                <path fill-rule="evenodd" d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z" clip-rule="evenodd" />
              </svg>
            </div>
          </span>
          <span class="tooltip top cursor-pointer" aria-label="Move up">
            <div class="icon-button"
              phx-click="move_component"
              phx-value-component_index="<%= @component_form.index %>"
              phx-target="#article-form"
              phx-value-offset="-1">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5.293 9.707a1 1 0 010-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 01-1.414 1.414L11 7.414V15a1 1 0 11-2 0V7.414L6.707 9.707a1 1 0 01-1.414 0z" clip-rule="evenodd" />
              </svg>
            </div>
          </span>
          <span class="tooltip top cursor-pointer" aria-label="Move down">
            <div class="icon-button"
              phx-click="move_component"
              phx-value-component_index="<%= @component_form.index %>"
              phx-target="#article-form"
              phx-value-offset="1">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M14.707 10.293a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 111.414-1.414L9 12.586V5a1 1 0 012 0v7.586l2.293-2.293a1 1 0 011.414 0z" clip-rule="evenodd" />
              </svg>
            </div>
          </span>
          <span class="tooltip top cursor-pointer" aria-label="Delete">
            <div class="icon-button"
              phx-click="delete_component"
              phx-target="#article-form"
              phx-value-component_index="<%= @component_form.index %>">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
              </svg>
            </div>
          </span>
        </div>
      </div>
      <%= case component.type do %>
        <% "file" -> %>
          <%= live_component @socket, Page.FileComponent.Form, Map.put(assigns, :component, component) %>
        <% "image" -> %>
          <%= live_component @socket, Page.ImageComponent.Form, Map.put(assigns, :component, component) %>
        <% "text" -> %>
          <%= live_component @socket, Page.TextComponent.Form, Map.put(assigns, :component, component) %>
        <% "video" -> %>
          <%= live_component @socket, Page.VideoComponent.Form, Map.put(assigns, :component, component) %>
      <% end %>
    </div>
    """
  end
end
