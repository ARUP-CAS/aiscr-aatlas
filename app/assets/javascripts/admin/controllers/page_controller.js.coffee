Admin.PageController = Admin.ObjectController.extend Admin.UploadMixin,
  needs: ['tagsSelect']

  title: Admin.translatedProperty('title')
  subtitle: Admin.translatedProperty('subtitle')
  textContent: Admin.translatedProperty('textContent')
  mapTextContent: Admin.translatedProperty('mapTextContent')
  address: Admin.translatedProperty('address')
  era: Admin.translatedProperty('era')

  metaTitle: Admin.translatedProperty('metaTitle')
  metaDescription: Admin.translatedProperty('metaDescription')
  textContent: Admin.translatedProperty('textContent')

  titlePlaceholder: Admin.translatedProperty('title',fallback: true)
  subtitlePlaceholder: Admin.translatedProperty('subtitle',fallback: true)
  textContentPlaceholder: Admin.translatedProperty('textContent',fallback: true)  
  mapTextContentPlaceholder: Admin.translatedProperty('mapTextContent',fallback: true)  
  addressPlaceholder: Admin.translatedProperty('address',fallback: true)  
  eraPlaceholder: Admin.translatedProperty('era',fallback: true)  
  
  metaTitlePlaceholder: Admin.translatedProperty('metaTitle',fallback: true)
  metaDescriptionPlaceholder: Admin.translatedProperty('metaDescription',fallback: true)  