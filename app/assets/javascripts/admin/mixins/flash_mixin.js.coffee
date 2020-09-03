Admin.FlashMixin = Ember.Mixin.create
  flashInfo: (msg) ->
    @setFlash('success',msg)    

  flashError: (msg) ->
    @setFlash('error',msg)    

  setFlash: (type,msg) ->
    flash = Ember.Object.create(type: type, message: msg)
    controller = if @get('controllers.application')
                   @get('controllers.application')
                 else
                   @controllerFor('application')
    controller.set('flash',flash)          
