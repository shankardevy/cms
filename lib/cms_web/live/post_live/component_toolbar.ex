defmodule CmsWeb.PostLive.ComponentToolbar do
  use CmsWeb, :live_component

  alias Cms.Contents
  def render(assigns) do
    ~L"""

    <div @click="{display_new = !display_new; return false}" x-show="!display_new" class="relative <%= if(@persistent, do: "opacity-100", else: "opacity-0") %> hover:opacity-100">
      <div class="absolute inset-0 flex items-center" aria-hidden="true">
        <div class="w-full border-t border-dashed	border-gray-300"></div>
      </div>
      <div class="relative flex justify-center">
        <button @click="{display_new = !display_new; return false}" x-show="!display_new" type="button" class="inline-flex items-center shadow-sm px-4 py-1.5 border border-gray-300 text-sm leading-5 font-medium rounded-full text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          <!-- Heroicon name: solid/plus-sm -->
          <svg class="-ml-1.5 mr-1 h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z" clip-rule="evenodd" />
          </svg>
          <span>Add new</span>
        </button>
      </div>
    </div>

    <div @click.away="display_new = false" class="relative bg-white m-0 flex justify-center" x-data="{display_new: false}" data-element="insert-buttons">

      <div x-show="display_new" class="grid grid-cols-4 gap-4">
        <%= for component <- @components do %>
          <div phx-click="insert_component"
              phx-value-type="<%= component.type %>"
              phx-value-index="<%= @index %>"
              phx-target="<%= @myself %>"
              @click="display_new = !display_new"
              class="col-span-1 bg-white shadow sm:rounded-lg cursor-pointer hover:bg-gray-50">
            <div class="px-4 py-5 sm:p-6">
              <h3 class="text-lg leading-6 font-medium text-gray-900">
                <%= component.title %>
              </h3>
              <div class="mt-2 max-w-xl text-sm text-gray-500">
                <p>
                  Lorem ipsum dorem datum
                </p>
              </div>
            </div>
          </div>
        <% end %>
      </div>

    </div>
    """
  end

  def handle_event("insert_component", %{"index" => _, "type" => _} = params, socket) do
    {:ok, _component} = Contents.create_component(socket.assigns.post, params)

    {:noreply, socket}
  end
end
