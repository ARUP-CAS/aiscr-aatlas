Admin.PlacesRoute = Admin.BaseRoute.extend
  model: ->
    @store.find('place')
