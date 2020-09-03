Admin.PageTabsView = Ember.View.extend
  templateName: 'partials/page_tabs'

  # required
  route: null

  textRoute: ( -> "#{@get('route')}.text").property('route')
  mediaRoute: ( -> "#{@get('route')}.media").property('route')
  linksRoute: ( -> "#{@get('route')}.links").property('route')    
