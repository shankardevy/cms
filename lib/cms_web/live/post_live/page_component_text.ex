defmodule Page.Component.Text do
  use CmsWeb, :live_component

  alias Cms.Contents

  def render(assigns) do
    ~L"""
    <div class="prose">
    I’ve written a few thousand words on why traditional “semantic class names” are the reason CSS is hard to maintain, but the truth is you’re never going to believe me until you actually try it. If you can suppress the urge to retch long enough to give it a chance, I really think you'll wonder how you ever worked with CSS any other way.
    </div>
    """
  end
end
