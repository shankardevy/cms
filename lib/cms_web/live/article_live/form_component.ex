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

  @impl true
  def handle_event("insert_component", %{"index" => index, "type" => type}, socket) do

    article_params = %{
      "components" => %{
        "0" => %{
          "data" => %{
            "type" => type
          },
          "id" => Ecto.UUID.generate()
        },
        "1" => %{
          "data" => %{
            "type" => type
          },
          "id" => Ecto.UUID.generate()
        },
        "2" => %{
          "data" => %{
            "type" => type
          },
          "id" => Ecto.UUID.generate()
        }
      },
      "title" => "Test"
    }

    changeset =
      socket.assigns.article
      |> Content.change_article(article_params)
      |> Map.put(:action, :validate)


    # data = case type do
    #   "text" ->     %Cms.Content.Components.Text{
    #     type: type
    #   }
    #   "video" ->     %Cms.Content.Components.Video{
    #     type: type
    #   }
    #   "image" ->     %Cms.Content.Components.Image{
    #     type: type
    #   }
    #   "file" ->     %Cms.Content.Components.File{
    #     type: type
    #   }
    # end

    # index = ensure_integer(index)

    # components = changeset.data.components
    # new_component = %Cms.Content.Component{
    #   data: data,
    #   id: Ecto.UUID.generate()
    # }
    # new_components = List.insert_at(components, index, new_component)

    # changeset = put_in(changeset.data.components, new_components)
    # IO.inspect changeset, label: "Changeset when adding new component"
    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"article" => article_params}, socket) do
    IO.inspect article_params, label: "validate"
    changeset =
      socket.assigns.article
      |> Content.change_article(article_params)
      |> Map.put(:action, :validate)

    IO.inspect changeset.changes.components, label: "Changes"
    IO.inspect Ecto.Changeset.get_field(changeset, :components), label: "Changeset field"
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
