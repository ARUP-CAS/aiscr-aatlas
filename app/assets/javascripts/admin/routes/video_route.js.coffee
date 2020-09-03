Admin.VideoRoute = Admin.BaseRoute.extend({
  model: (params) ->
    @store.find('video',params.video_id)
})
