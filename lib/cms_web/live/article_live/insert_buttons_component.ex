defmodule CmsWeb.ArticleLive.InsertButtonsComponent do
  use CmsWeb, :live_component

  def render(assigns) do
    ~L"""
    <div  @click.away="display_new = false" class="relative top-0.5 m-0 flex justify-center" x-data="{display_new: false}" data-element="insert-buttons">
      <div class="absolute z-10 <%= if(@persistent, do: "opacity-100", else: "opacity-0") %> hover:opacity-100 focus-within:opacity-100 flex space-x-2 justify-center items-center">
        <div @click="{display_new = !display_new; return false}" x-show="!display_new" class="cursor-pointer p-2">Add a new section</div>
      </div>

      <div x-show="display_new" class="grid grid-cols-4 gap-4">
        <div phx-click="insert_component"
            phx-value-type="text"
            phx-value-index="<%= @insert_section_index %>"
            phx-target="#article-form"
            @click="display_new = !display_new"
            class="col-span-1 bg-white shadow sm:rounded-lg cursor-pointer hover:bg-gray-50">
          <div class="px-4 py-5 sm:p-6">
            <h3 class="text-lg leading-6 font-medium text-gray-900">
              Text component
            </h3>
            <div class="mt-2 max-w-xl text-sm text-gray-500">
              <p>
                Text with visual editor
              </p>
            </div>
          </div>
        </div>
        <div phx-click="insert_component"
            phx-value-type="image"
            phx-value-index="<%= @insert_section_index %>"
            phx-target="#article-form"
            @click="display_new = !display_new"
            class="col-span-1 bg-white shadow sm:rounded-lg cursor-pointer hover:bg-gray-50">
          <div class="px-4 py-5 sm:p-6">
            <h3 class="text-lg leading-6 font-medium text-gray-900">
              Image component
            </h3>
            <div class="mt-2 max-w-xl text-sm text-gray-500">
              <p>
              Upload an image with title description and caption
              </p>
            </div>
          </div>
        </div>
        <div phx-click="insert_component"
            phx-value-type="video"
            phx-value-index="<%= @insert_section_index %>"
            phx-target="#article-form"
            @click="display_new = !display_new"
            class="col-span-1 bg-white shadow sm:rounded-lg cursor-pointer hover:bg-gray-50">
          <div class="px-4 py-5 sm:p-6">
            <h3 class="text-lg leading-6 font-medium text-gray-900">
              Embed Video
            </h3>
            <div class="mt-2 max-w-xl text-sm text-gray-500">
              <p>
              Embed media from Youtube, Vimeo
              </p>
            </div>
          </div>
        </div>
        <div phx-click="insert_component"
            phx-value-type="file"
            phx-value-index="<%= @insert_section_index %>"
            phx-target="#article-form"
            @click="display_new = !display_new"
            class="col-span-1 bg-white shadow sm:rounded-lg cursor-pointer hover:bg-gray-50">
          <div class="px-4 py-5 sm:p-6">
            <h3 class="text-lg leading-6 font-medium text-gray-900">
              File
            </h3>
            <div class="mt-2 max-w-xl text-sm text-gray-500">
              <p>
              Upload any file PDF, Doc, JPEG
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
