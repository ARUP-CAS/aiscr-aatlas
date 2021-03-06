Admin.Page = DS.Model.extend
  tags: DS.hasMany 'tag'
  mediaPlacements: DS.hasMany('mediaPlacement',async: true)
  mediaItems: DS.hasMany('mediaItem',async: true)
  mediaPlacementsCount: DS.attr 'number'
  latitude: DS.attr 'number'
  longitude: DS.attr 'number'
  updatedAt: DS.attr 'isodate'
  createdAt: DS.attr 'isodate'
