Admin.TagsRoute = Admin.BaseRoute.extend({
  model: ->
    @store.find('tag')
})
