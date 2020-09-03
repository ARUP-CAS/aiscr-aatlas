Admin.MediaItemController = Admin.ObjectController.extend
  isEditing: false
  # copyright: Admin.translatedProperty('copyright')

  actions:
    saveItem: ->
      @get('content').save()
      @set 'isEditing',false
      false

    rollbackItem: ->
      @get('content').rollback()
      @set 'isEditing',false
      false

    toggleEditing: (value) ->
      @set 'isEditing',value
      false
