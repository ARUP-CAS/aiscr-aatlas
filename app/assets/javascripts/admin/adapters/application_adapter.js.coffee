Admin.RailsAdapter = DS.ActiveModelAdapter.extend
  headers: (->
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  ).property().volatile()

  # TODO: fix controllers and uncomment this
  # coalesceFindRequests: true

  ajaxError: (jqXHR) ->
    invalid_error = @_super(jqXHR)

    if jqXHR && jqXHR.status == 422
      json = Ember.$.parseJSON(jqXHR.responseText)
      invalid_error.full_rails_message = json.full_message
      invalid_error.description = json.full_message
      console.error invalid_error.full_rails_message

    invalid_error


Admin.ApplicationAdapter = Admin.RailsAdapter.extend
  namespace: 'admin'

