Admin.TagController = Admin.ObjectController.extend
  title: Admin.translatedProperty('title')
  titlePlaceholder: Admin.translatedProperty('title',fallback: true)
