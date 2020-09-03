Admin.PageRoute = Admin.BaseRoute.extend Admin.AjaxMixin,
  setupController: (controller,model) ->
    @_super(controller,model)
    @controllerFor('tagsSelect').set('content', @store.filter('tag',{},-> true))

  # redirect: (model,transition) ->
  #   if page = @get('model.firstObject')
  #     @transitionTo 'project', page

  # activate: (page,transition) ->
  #   page = @currentModel
  #   type = page.constructor.typeKey.decamelize()
  #   unless page.get('isNew')
  #     @transitionTo("#{type}.media",page)

  actions:
    closeModal: ->
      @disconnectOutlet outlet: 'modal', parentView: 'application'
      false

    moveMediaPlacement: (id,pos) ->
      @postToServer("/admin/media_placements/#{id}/insert_at",{position: pos}).then (response) =>
        @store.pushPayload('media_placement',response)
      false

    removeMediaPlacement: (p) ->
      p.destroyRecord().then (=>
        @flashInfo 'Media removed from this page.'), (=>
        @flashError 'Failed to remove the media item from this page.'
      )
      false

    uploadFinished: (s3url,title,mimeType) ->
      page_id = @currentModel.get('id')

      # HACK
      type = if mimeType.indexOf('video') == 0
               'video'
             else if mimeType.indexOf('image') == 0
               'image'
             else
               'document'

      @postToServer("/admin/media_items", media_item: { source_url: s3url, page_ids: [page_id], type: type }).then ( (payload) =>
        @store.pushPayload('page',payload)
        @flashInfo 'File uploaded.'), (=>
        @flashError 'File upload failed.'
      )

      false
