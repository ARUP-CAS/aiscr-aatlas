Admin.VideosRoute = Admin.BaseRoute.extend({
  model: ->
    @store.find('video')
})
