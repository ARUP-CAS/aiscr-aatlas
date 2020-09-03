Admin.PlacesNewRoute = Admin.PageRoute.extend
  controllerName: 'page'
  templateName: 'place'
  model: ->
    @store.createRecord('place')

  afterSave: (r) ->
    @flashInfo('Saved.')            
    @transitionTo 'place', r.get('id')
