Admin.MediaPlacementController = Admin.ObjectController.extend Admin.AjaxMixin, Admin.UploadMixin, Admin.FlashMixin,
  title: Admin.translatedProperty('title')
  isEditing: false

  actions:
    uploadFinished: (s3url,title,mimeType) ->
      @set 'progress', null
      media_item_id = @get('mediaItem.id')
      data = { media_item: { cover_url: s3url }}

      @postToServer("/admin/media_items/#{media_item_id}",data,{ type: 'PUT'}).then ( =>
        @flashInfo 'Cover uploaded.'), (=>
        @flashError 'Cover upload failed.'
      )
      false  

    saveItem: ->
      @get('content').save().then (=>
        @flashInfo 'Saved.'), ((e) =>
        @flashError 'Failed.')
      @set 'isEditing',false
      false

    rollbackItem: ->
      @get('content').rollback()
      @set 'isEditing',false
      false

    toggleEditing: (value) ->
      @set 'isEditing',value
      false

    togglePlan: ->
      id = @get('model.id')
      data = {}
      data['media_placement[is_plan]'] = !@get('model.isPlan')
      @postToServer("/admin/media_placements/#{id}",data,{type:'PUT'}).then (payload) =>
        @set 'model.isPlan', !@get('model.isPlan')
        console.log "Is plan:#{!@get('model.isPlan')}"
      false
