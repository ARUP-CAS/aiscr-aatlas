Admin.StarView = Ember.View.extend
  tagName: 'i'
  classNameBindings: [':star',':fa',':fa-2x',':fa-map-marker','controller.isPlan:on:off']

  click: ->
    @get('controller').send('togglePlan')
