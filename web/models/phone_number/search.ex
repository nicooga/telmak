defmodule Telmak.PhoneNumber.Search do
  import Ecto.Query

  def apply_filters(query, filters) when is_map(filters) do
    Enum.reduce filters, query, fn({filter, value}, q)->
      apply_filter(q, filter, value)
    end
  end

  defp apply_filter(query, "number", number) do
    from pn in query, where: pn.number == ^number
  end

  defp apply_filter(query, "dont_call", bool) do
    from pn in query, where: pn.dont_call == ^bool
  end
end
