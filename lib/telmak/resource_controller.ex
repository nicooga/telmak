defmodule Telmak.ResourceController do
  defmacro __using__(opts_list) do
    quote do
      use Phoenix.Controller
      alias Telmak.Repo

      def index(conn, params) do
        render conn, data: Repo.all(resource_collection(params))
      end

      def show(conn, %{"id"=>id}) do
        render conn, data: Repo.get(resource_model, id)
      end

      def create(conn, %{"data" => data}) do
        handle_action conn, data, struct(resource_model)
      end

      def update(conn, %{"id"=>id, "data"=>data}) do
        struct = Repo.get!(resource_model, id)
        handle_action conn, data, struct
      end

      def delete(conn, %{"id" => id}) do
        Repo.get!(resource_model, id) |> Repo.delete!()
        send_resp(conn, :no_content, "")
      end

      defp handle_action(conn, data, struct) do
        resource_params = JaSerializer.Params.to_attributes(data)

        changeset = build_changeset(
          struct,
          resource_params,
          Guardian.Plug.current_resource(conn)
        )

        case Repo.insert_or_update(changeset) do
          {:ok, r} ->
            after_action_success r, resource_params

            conn
            |> put_resp_header("location", resource_location(conn, r))
            |> render(:show, data: r |> preload_assocs)

          {:error, r} ->
            after_action_error r, resource_params

            conn
            |> put_status(:unprocessable_entity)
            |> render(:errors, data: r |> preload_assocs)
        end
      end

      defp preload_assocs(resource) do
        case unquote(opts_list) |> Keyword.fetch(:preload_assocs) do
          {:ok, arg} when is_list(arg) or is_atom(arg) ->
            Repo.preload(resource, arg)
          :error -> resource
        end
      end

      defp build_changeset(struct, resource_params, current_user) do
        case get_func_from_opts(:build_changeset) do
          {:ok, func} -> func.(struct, resource_params, current_user)
          :not_found -> resource_model.changeset(struct, resource_params)
        end
      end

      defp resource_collection(params) do
        case get_func_from_opts(:resource_collection) do
          {:ok, func} -> func.(params)
          :not_found -> resource_model
        end
      end

      defp resource_model do
        unquote(opts_list |> Keyword.fetch!(:resource_model))
      end

      defp after_action_error(resource, resource_params) do
        case get_func_from_opts(:after_action_error) do
          {:ok, func} -> func.(resource, resource_params)
          :not_found -> :nothing
        end
      end

      defp after_action_success(resource, resource_params) do
        case get_func_from_opts(:after_action_success) do
          {:ok, func} -> func.(resource, resource_params)
          :not_found -> :nothing
        end
      end

      defp resource_location(conn, resource) do
        case get_func_from_opts(:resource_location) do
          {:ok, func} -> func.(conn, resource)
        end
      end

      defp get_func_from_opts(name) do
        case unquote(opts_list) |> Keyword.fetch(name) do
          {:ok, func} when is_function(func) -> {:ok, func}
          :error -> :not_found
        end
      end
    end
  end
end
