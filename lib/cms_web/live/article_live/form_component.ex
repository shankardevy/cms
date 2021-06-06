defmodule CmsWeb.ArticleLive.FormComponent do
  use CmsWeb, :live_component

  alias Cms.Content

  @impl true
  def update(%{article: article} = assigns, socket) do
    changeset = Content.change_article(article)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  defp get_components_changeset(components) do
    Enum.map(components, fn(c) -> Content.change_component(c) end)
  end

  @impl true
  def handle_event("insert_component", %{"index" => index, "type" => type}, socket) do
    changeset = socket.assigns.changeset
    index = ensure_integer(index) |> max(0)

    data = case type do
      "text" -> %Page.TextComponent{type: "text"}
      "file" -> %Page.FileComponent{type: "file"}
      "image" -> %Page.ImageComponent{type: "image"}
      "video" -> %Page.VideoComponent{type: "video"}
    end

    new_component = Content.change_component(%Cms.Content.Component{index: index, data: data})

    changes = socket.assigns.changeset.changes
    components = case Map.get(changes, :components) do
      nil -> get_components_changeset(changeset.data.components)
      components -> components
    end

    new_components = List.insert_at(components, index, new_component)
                    |> Enum.with_index()
                    |> Enum.map(fn({component, index}) ->
                      Ecto.Changeset.put_change(component, :index, index)
                    end)

    changes = Map.put(changes, :components, new_components)
    changeset = %{changeset | changes: changes}

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"article" => article_params}, socket) do
    changeset =
      socket.assigns.article
      |> Content.change_article(article_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"article" => article_params}, socket) do
    save_article(socket, socket.assigns.action, article_params)
  end

  def handle_event("delete_component", %{"component_index" => index}, socket) do
    index = ensure_integer(index)

    changeset = socket.assigns.changeset

    changes = changeset.changes
    components = case Map.get(changes, :components) do
      nil -> get_components_changeset(changeset.data.components)
      components -> components
    end

    {component, components} = List.pop_at(components, index)
    component = Cms.Content.Component.set_for_deletion(component)
    components = List.insert_at(components, index, component)

    changes = Map.put(changes, :components, components)

    changeset = %{changeset | changes: changes}

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("move_component", %{"component_index" => index, "offset" => offset}, socket) do
    offset = ensure_integer(offset)
    index = ensure_integer(index)

    changeset = socket.assigns.changeset

    changes = changeset.changes
    components = case Map.get(changes, :components) do
      nil -> get_components_changeset(changeset.data.components)
      components -> components
    end

    new_index = (index + offset) |> clamp_index(components)

    {component, components} = List.pop_at(components, index)
    components = List.insert_at(components, new_index, component)

    changes = Map.put(changes, :components, components)
    changeset = %{changeset | changes: changes}

    {:noreply, assign(socket, :changeset, changeset)}
  end

  defp save_article(socket, :edit, article_params) do
    case Content.update_article(socket.assigns.article, article_params) do
      {:ok, _article} ->
        {:noreply,
         socket
         |> put_flash(:info, "Article updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_article(socket, :new, article_params) do
    case Content.create_article(article_params) do
      {:ok, _article} ->
        {:noreply,
         socket
         |> put_flash(:info, "Article created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp clamp_index(index, list) do
    index |> max(0) |> min(length(list) - 1)
  end

  defp ensure_integer(n) when is_integer(n), do: n
  defp ensure_integer(n) when is_binary(n), do: String.to_integer(n)

  defp empty_components?([]), do: true

  defp empty_components?(components) do
    Enum.reject(components, fn
      %Ecto.Changeset{} = component -> Ecto.Changeset.get_field(component, :delete)
      component -> component.delete
    end)
    |> Enum.empty?
  end
end
