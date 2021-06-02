defmodule CmsWeb.ArticleLive.FormComponent do
  use CmsWeb, :live_component

  alias Cms.Content

  @impl true
  def update(%{article: article} = assigns, socket) do
    # type = "text"
    # article_params = %{
    #   "components" => %{
    #     "0" => %{
    #       "data" => %{
    #         "type" => type
    #       },
    #       "id" => Ecto.UUID.generate()
    #     },
    #     "1" => %{
    #       "data" => %{
    #         "type" => type
    #       },
    #       "id" => Ecto.UUID.generate()
    #     },
    #     "2" => %{
    #       "data" => %{
    #         "type" => type
    #       },
    #       "id" => Ecto.UUID.generate()
    #     }
    #   },
    #   "title" => "Test"
    # }

    # changeset = Content.change_article(article, article_params)

    changeset = Content.change_article(article)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  defp get_components_changeset(components) do
    Enum.map(components, fn(c) -> Content.change_component(c) |> Map.put(:action, :validate) end)
  end

  @impl true
  def handle_event("insert_component", %{"index" => index, "type" => type}, socket) do
    changeset = socket.assigns.changeset
    data = case type do
      "text" -> %Cms.Content.Components.Text{type: "text"}
      "cta" -> %Cms.Content.Components.CTA{type: "cta"}
      "file" -> %Cms.Content.Components.File{type: "file"}
      "gallery" -> %Cms.Content.Components.Gallery{type: "gallery"}
      "image" -> %Cms.Content.Components.Image{type: "image"}
      "video" -> %Cms.Content.Components.Video{type: "video"}
    end
    new_component = Content.change_component(%Cms.Content.Component{data: data})

    changes = socket.assigns.changeset.changes
    components = case Map.get(changes, :components) do
      nil -> get_components_changeset(changeset.data.components)
      components -> components
    end
    new_components = components ++ [new_component]

    changes = Map.put(changes, :components, new_components)
    changeset = %{changeset | changes: changes}

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"article" => article_params}, socket) do
    IO.inspect article_params, label: "validate"
    changeset =
      socket.assigns.article
      |> Content.change_article(article_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"article" => article_params}, socket) do
    IO.inspect article_params, label: "Save"
    save_article(socket, socket.assigns.action, article_params)
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

  defp ensure_integer(n) when is_integer(n), do: n
  defp ensure_integer(n) when is_binary(n), do: String.to_integer(n)
end
