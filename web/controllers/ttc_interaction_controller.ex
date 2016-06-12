defmodule Telmak.TtcInteractionController do
  use Telmak.Web, :controller
  alias Telmak.TtcInteraction

  use Telmak.ResourceController,
    resource_model: TtcInteraction,
    resource_location: &(ttc_interaction_path(&1, :show, &2)),
    build_changeset: fn(resource, params, current_user)->
      TtcInteraction.changeset(
        resource,
        params |> Map.put("telemarketer_id", current_user.id)
      )
    end,
    preload_assocs: ~w(telemarketer customer)a
end
