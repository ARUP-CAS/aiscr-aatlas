Admin.MediaPlacementsController = Ember.ArrayController.extend
  sortProperties: [ 'position' ]
  sortAscending: true
  sliceSize: 4

  slices: (->
    collection = @get('arrangedContent')
    length = collection.get('length')
    size = @get('sliceSize')
    result = []

    i = 0
    while i < length
      result.pushObject(collection.slice(i,i+size))
      i += size

    result
  ).property('arrangedContent.@each.position')
