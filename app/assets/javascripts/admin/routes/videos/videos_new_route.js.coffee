Admin.VideosNewRoute = Admin.BaseRoute.extend({
  renderTemplate: ->
    @render('video',model: @modelFor(@routeName))

  model: ->
    @store.createRecord('video')
})
