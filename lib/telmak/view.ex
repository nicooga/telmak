defmodule Telmak.View do
  defmacro preload(assocs) when is_list(assocs) do
    for assoc <- assocs do
      quote do: preload(unquote(assoc))
    end
  end

  defmacro preload(assoc) when is_atom(assoc) do
    quote do
      def unquote(assoc)(struct, _conn) do
        case struct.unquote(assoc) do
          %Ecto.Association.NotLoaded{} ->
            struct
            |> Ecto.assoc(unquote(assoc))
            |> Telmak.Repo.all
          other -> other
        end
      end
    end
  end
end
