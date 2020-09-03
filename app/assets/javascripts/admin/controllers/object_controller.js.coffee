Admin.ObjectController = Ember.ObjectController.extend
  needs: ['application']
#  availableLocales: Ember.computed.alias('controllers.application.locales')
  contentLocale: Ember.computed.alias('controllers.application.contentLocale')
