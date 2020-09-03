Admin.ApplicationController = Ember.ObjectController.extend
  flash: null
  contentLocale: 'cs'
  
  localeOptions: (->
    # TODO: replace by Ember-i18n    
    t = (key) ->
      translations =
        "locales.cs.name": 'Čeština'
        "locales.en.name": 'Angličtina'
      translations[key]

    Admin.locales.map (locale) ->
      { code: locale, label: t("locales.#{locale}.name") }
  ).property()


