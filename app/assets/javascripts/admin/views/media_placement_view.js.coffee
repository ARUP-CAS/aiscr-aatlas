Admin.MediaPlacementView = Ember.View.extend
  classNameBindings: [ 'draggingOver', ':media-placement',':thumbnail']
  attributeBindings: [ 'draggable' ]
  draggingOver: false
  draggable: true

  dragStart: (event) ->
    event.dataTransfer.setData 'mediaPlacementId', @get('controller.id')

  dragLeave: (event) ->
    event.preventDefault()
    @set 'draggingOver', false

  dragOver: (event) ->
    event.preventDefault()
    @set 'draggingOver', true

  drop: (event) ->
    @set 'draggingOver', false
    pos = @get('controller.position') + 1
    id = event.dataTransfer.getData 'mediaPlacementId'
    @get('controller').send 'moveMediaPlacement',id,pos
    
