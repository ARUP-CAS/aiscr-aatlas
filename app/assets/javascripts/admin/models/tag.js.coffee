Admin.Tag = DS.Model.extend
  name: DS.attr 'string'
  titleCs: DS.attr 'string'
  titleEn: DS.attr 'string'
  era: DS.attr 'boolean'
  notEra: Ember.computed.not('era')
