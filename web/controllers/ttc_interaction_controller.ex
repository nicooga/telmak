defmodule Telmak.TtcInteractionController do
  use Telmak.Web, :controller

  use Telmak.ResourceController,
    resource_model: Telmak.TtcInteraction,
    resource_location: &(ttc_interaction_path(&1, :show, &2))
end
