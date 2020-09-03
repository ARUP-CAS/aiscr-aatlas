Admin.MediaItemView = Ember.View.extend
  keyPress: (e) ->
    if e.keyCode == 13
      @get('controller').send('saveItem')
      false
    else  
      true    
          
          
