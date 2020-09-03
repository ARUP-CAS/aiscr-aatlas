Admin.PageSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    tags: { serialize: 'ids', deserialize: 'ids' }
    media_items: { serialize: 'ids', deserialize: 'ids' }
    media_placements: { serialize: 'ids', deserialize: 'ids' }
    
Admin.PlaceSerializer = Admin.PageSerializer.extend()
