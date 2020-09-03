Admin.TagRoute = Admin.BaseRoute.extend({
  model: (params) ->
    @store.find('tag',params.tag_id)
})
