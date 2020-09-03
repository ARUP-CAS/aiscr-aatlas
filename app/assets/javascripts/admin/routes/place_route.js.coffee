Admin.PlaceRoute = Admin.PageRoute.extend
  model: (params) ->
    @store.find('place',params.place_id)
