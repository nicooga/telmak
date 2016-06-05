defmodule Telmak.BaseRouter do
  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)
    end
  end

  @default_opts [except: ~w(new edit)a]

  @doc """
    Example Usage:

      ja_resources :users, UserController
      ja_resources :sessions, UserController

      # Equivalent to
      # resources "/users", UserController, except: ~w(new edit)a
      # resources "/sessions", SesssionsController, except: ~w(new edit)a
  """
  defmacro ja_resources(type, opts) do
    path = "/#{type}"

    {controller, _} =
      type
      |> Atom.to_string
      |> Inflex.singularize
      |> Macro.camelize
      |> (&("#{&1}Controller")).()
      |> Code.eval_string

    quote do
      resources(
        unquote(path),
        unquote(controller),
        unquote(opts)
      )
    end
  end

  defmacro ja_resources(type) when is_atom(type) do
    quote do: ja_resources(unquote(type), unquote(@default_opts))
  end
end
