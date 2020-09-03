Admin.MediaPlacementSerializer = DS.ActiveModelSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    mediaItem: { serialize: 'records', deserialize: 'ids' }
    page: { serialize: false, deserialize: 'ids' }
