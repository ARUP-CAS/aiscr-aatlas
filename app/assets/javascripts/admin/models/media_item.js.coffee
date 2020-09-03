Admin.MediaItem = DS.Model.extend
  mediaPlacements: DS.hasMany('mediaPlacement')
  pages: DS.hasMany('page')

  type: DS.attr 'string'
  copyrightEn: DS.attr 'string'
  copyrightCs: DS.attr 'string'
  thumbnailUrl: DS.attr 'string'
  sourceUrl: DS.attr 'string'

  isVideo: (->
    t = @get('type')
    t == 'video'
  ).property('type')
