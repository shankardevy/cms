defmodule Page.VideoComponent do
  use CmsWeb, :live_component

  defstruct title: "", url: "", caption: "", path: "", type: "video"

  def render(assigns) do
    ~L"""
      View mode
    """
  end

  defmodule Form do
    use CmsWeb, :live_component

    def render(assigns) do
      ~L"""
      <div class="sm:col-span-4">
        <label for="about" class="block text-sm font-medium text-gray-700">
          Embedded video
        </label>
        <div class="mt-1">
          <input type="hidden" name="<%= @component_form.name %>[data][type]" value="video" />
          <textarea x-data="{resize: () => { $el.style.height = '40px'; $el.style.height = ($el.scrollHeight + 40) + 'px'}}" x-init="" x-on:input="" name="<%= @component_form.name %>[data][url]" rows="3" class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"><%= @component.url %></textarea>
        </div>
      </div>
      """
    end
  end
end
