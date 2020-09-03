Admin.BaseRoute = Ember.Route.extend Admin.AjaxMixin, Admin.FlashMixin,
  actions:
    error: (error,transition) ->
      if error and error.status == 401
        window.location = '/users/sign_in?msg=You+have+signed+out+in+another+window'
      true


    save: (record) ->
      record ||= @currentModel
      console.log 'Saving',record
      record.get('errors').clear()
      record.save().then ( (saved_record) =>
        @afterSave(saved_record)
       ), ( (e) =>
         @flashError 'Save failed.'
       )
      false

    remove: (record) ->
      record ||= @currentModel
      if record.get('isNew')
        record.deleteRecord()
      else
        record.destroyRecord().then (=>
          @flashInfo 'Deleted.'
          @goToPluralRoute()
          ), ( (e) =>
           console.error e
           @flashError "Failed."
          )
      false

    rollback: ->
      @currentModel.get('errors').clear()
      @currentModel.rollback()
      @goToPluralRoute()
      false

  afterSave: (record) ->
    @flashInfo('Saved.')

  goToPluralRoute: (record = @currentModel) ->
    next_route = record.constructor.typeKey.decamelize().pluralize()
    @transitionTo next_route if @routeName != next_route

  _setupPagination: (controller,model) ->
    modelType = model.get('type') if model.get?
    if hash = @store.typeMapFor(modelType).metadata.pagination
      controller.set('controllers.pagination.model', Ember.Object.create(hash))
