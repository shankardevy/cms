defmodule CmsWeb.ArticleLive.SectionComponent do
  use CmsWeb, :live_component

  def ensure_component(component) when is_struct(component), do: component
  def ensure_component(map) when is_map(map) do
    {:ok, component} = Cms.Content.ComponentData.load(map)
    component
  end

  def render(assigns) do
    ~L"""
    <div class="mt-4">
      <%= hidden_inputs_for(@component_form) %>
      <% component = ensure_component(input_value(@component_form, :data)) %>
      <%= case component.type do %>
        <% "file" -> %>
        <div class="sm:col-span-4">
          <input type="hidden" name="<%= @component_form.name %>[data][type]" value="file" />
          <label for="cover_photo" class="block text-sm font-medium text-gray-700">
            File
          </label>
          <div class="mt-1 flex justify-center px-6 pt-5 pb-6 border-2 border-gray-300 border-dashed rounded-md">
            <div class="space-y-1 text-center">
              <svg class="mx-auto h-12 w-12 text-gray-400" stroke="currentColor" fill="none" viewBox="0 0 48 48" aria-hidden="true">
                <path d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
              </svg>
              <div class="flex text-sm text-gray-600">
                <label for="file-upload" class="relative cursor-pointer bg-white rounded-md font-medium text-indigo-600 hover:text-indigo-500 focus-within:outline-none focus-within:ring-2 focus-within:ring-offset-2 focus-within:ring-indigo-500">
                  <span>Upload a file</span>
                  <input id="file-upload" name="file-upload" type="file" class="sr-only">
                </label>
                <p class="pl-1">or drag and drop</p>
              </div>
              <p class="text-xs text-gray-500">
                PNG, JPG, GIF up to 10MB
              </p>
            </div>
          </div>
        </div>
        <% "image" -> %>
          <div class="sm:col-span-4">
            <input type="hidden" name="<%= @component_form.name %>[data][type]" value="image" />
            <label for="cover_photo" class="block text-sm font-medium text-gray-700">
              Cover photo
            </label>
            <div class="mt-1 flex justify-center px-6 pt-5 pb-6 border-2 border-gray-300 border-dashed rounded-md">
              <div class="space-y-1 text-center">
                <svg class="mx-auto h-12 w-12 text-gray-400" stroke="currentColor" fill="none" viewBox="0 0 48 48" aria-hidden="true">
                  <path d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
                </svg>
                <div class="flex text-sm text-gray-600">
                  <label for="file-upload" class="relative cursor-pointer bg-white rounded-md font-medium text-indigo-600 hover:text-indigo-500 focus-within:outline-none focus-within:ring-2 focus-within:ring-offset-2 focus-within:ring-indigo-500">
                    <span>Upload a file</span>
                    <input id="file-upload" name="file-upload" type="file" class="sr-only">
                  </label>
                  <p class="pl-1">or drag and drop</p>
                </div>
                <p class="text-xs text-gray-500">
                  PNG, JPG, GIF up to 10MB
                </p>
              </div>
            </div>
          </div>
        <% "text" -> %>
          <div class="sm:col-span-4">
            <label for="about" class="block text-sm font-medium text-gray-700">
              Text
            </label>
            <div class="mt-1">
              <input type="hidden" name="<%= @component_form.name %>[data][type]" value="text" />
              <textarea x-data="{resize: () => { $el.style.height = '40px'; $el.style.height = ($el.scrollHeight + 40) + 'px'}}" x-init="" x-on:input="" name="<%= @component_form.name %>[data][text]" rows="3" class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"><%= component.text %></textarea>
            </div>
          </div>

        <% "video" -> %>
          <div class="sm:col-span-4">
            <label for="about" class="block text-sm font-medium text-gray-700">
              Embedded video
            </label>
            <div class="mt-1">
              <input type="hidden" name="<%= @component_form.name %>[data][type]" value="video" />
              <textarea x-data="{resize: () => { $el.style.height = '40px'; $el.style.height = ($el.scrollHeight + 40) + 'px'}}" x-init="" x-on:input="" name="<%= @component_form.name %>[data][url]" rows="3" class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"><%= component.url %></textarea>
            </div>
          </div>
      <% end %>
    </div>
    """
  end
end
