Admin.ProgressBarView = Ember.View.extend
  classNames: [ 'progress' ]

  style: (->
    "width: #{@get('value')}%;"
  ).property('value')
