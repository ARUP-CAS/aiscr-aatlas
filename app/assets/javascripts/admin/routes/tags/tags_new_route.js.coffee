Admin.TagsNewRoute = Admin.BaseRoute.extend({
  renderTemplate: ->
    @render('tag',model: @modelFor(@routeName))

  model: ->
    @store.createRecord('tag')

  afterSave: (r) ->
    @flashInfo('Saved.')            
    @transitionTo 'tag', r.get('id')
})
