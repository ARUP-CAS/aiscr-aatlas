#= require barbecue

#= require_self
#= require ./store
#= require_tree ./serializers
#= require_tree ./adapters
#= require_tree ./mixins
#= require ./models/page
#= require_tree ./models
#= require ./controllers/object_controller
#= require ./controllers/page_controller
#= require_tree ./controllers
#= require ./views/form_group_view
#= require ./views/view
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./components
#= require_tree ./templates
#= require ./routes/base_route
#= require ./routes/page_route
#= require_tree ./routes
#= require ./router

# HACK - to deal with /admin namespacing of Emblem files
$ ->
  for key,template of Ember.TEMPLATES
    regexp = /^admin\//

    if key.match(regexp)
      unscoped = key.replace(regexp,'')
      Ember.TEMPLATES[unscoped] = template;
      console.info "Renamed template '#{key}' to '#{unscoped}'"

# HACK - monkey patching Ember to have groupBy
#
# http://stackoverflow.com/questions/21143843/ember-js-grouping-results
Ember.computed.groupBy = (collection, groupBy) ->
  dependentKey = "#{collection}.@each.#{groupBy}"

  Ember.computed dependentKey, ->
    result = []
    @get(collection).forEach (item) ->
      unless result.findBy groupBy, item.get(groupBy)
        data = content: []
        data[groupBy] = item.get(groupBy)
        result.pushObject Ember.Object.create(data)
      result.findBy(groupBy, item.get(groupBy)).get('content').pushObject item
    result



window.Admin = Ember.Application.create()
Admin.locales = ['cs','en']
