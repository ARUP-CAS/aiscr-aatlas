Admin.MediaItemSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    pages: { serialize: 'ids' }

  # keyForRelationship: (attr) ->
  #   console.info 'AA' + attr
  #   if attr == 'mediaItem'
  #     'media_item_attributes'
  #   else
  #     @_super(attr)
