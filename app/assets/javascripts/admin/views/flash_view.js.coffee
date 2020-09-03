Admin.FlashView = Ember.View.extend
  elementName: 'p'
  classNameBindings: [ ':flash','type' ]
  templateName: 'flash'

  type: Ember.computed.alias('controller.type')

  actions:
    close: ->
      @$().hide()

  showFlash: ( ->
    if msg = @get('controller.message')
      console.log 'Showing flash:',msg
      @$().fadeIn()
      Ember.run.later((=> @$().fadeOut() ),7000)
    else
      console.log 'No flash to show.'
  ).observes('controller.message').on('init')
