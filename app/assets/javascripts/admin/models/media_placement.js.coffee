Admin.MediaPlacement = DS.Model.extend
  titleEn: DS.attr 'string'
  titleCs: DS.attr 'string'
  position: DS.attr 'number'
  isPlan: DS.attr 'boolean'
  notPlan: Ember.computed.not('isPlan')
  # coverColumns: DS.attr 'number'

  mediaItem: DS.belongsTo('mediaItem')
  page: DS.belongsTo('page',async: true,polymorphic: true)
