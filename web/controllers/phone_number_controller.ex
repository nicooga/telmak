defmodule Telmak.PhoneNumberController do
  use Telmak.Web, :jsonapi_controller


  #use Telmak.ResourceController,
    #resource_model: PhoneNumber,
    #resource_location: &(phone_number_path(&1, :show, &2)),
    #build_changeset: fn
      #(resource, params = %{"number"=>number}, _current_user)->
        #case Repo.get_by(PhoneNumber, number: to_string(number)) do
          #nil -> PhoneNumber.changeset(resource, params)
          #pn -> PhoneNumber.changeset(pn, params)
        #end
      #(resource, params, _current_user)->
        #PhoneNumber.changeset(resource, params)
    #end,
    #resource_collection: fn
      #%{"filter"=>filters} ->
        #PhoneNumber |> PhoneNumber.Search.apply_filters(filters)
      #_ -> PhoneNumber
    #end
end
