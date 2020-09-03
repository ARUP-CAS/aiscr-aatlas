
# Galleries
window.initPhotoSwipeFromDOM = (gallerySelector) ->

  items = gallerySelector.find('.photoswipe-item')

  # parse picture index and gallery index from URL (#&pid=1&gid=2)
  photoswipeParseHash = ->
    hash = window.location.hash.substring(1)
    params = {}
    return params  if hash.length < 5
    vars = hash.split("&")
    i = 0

    while i < vars.length
      unless vars[i]
        i++
        continue
      pair = vars[i].split("=")
      if pair.length < 2
        i++
        continue
      params[pair[0]] = pair[1]
      i++
    params.gid = parseInt(params.gid, 10)  if params.gid
    return params  unless params.hasOwnProperty("pid")
    params.pid = parseInt(params.pid, 10)
    params


  openPhotoSwipe = (index, galleryElement, disableAnimation) ->
    pswpElement = document.querySelectorAll(".pswp")[0]
    gallery = undefined
    options = undefined
    # define options (if needed)
    options =
      index: index
      galleryUID: gallerySelector.data("pswp-uid")
      getThumbBoundsFn: (index) ->
        thumbnail = $(items[index]).find('img')[0]
        pageYScroll = $(window).scrollTop()
        rect = thumbnail.getBoundingClientRect()
        x: rect.left
        y: rect.top + pageYScroll
        w: rect.width

    options.showAnimationDuration = 0  if disableAnimation


    photoswipeItems = []
    items.each (index) ->
      # console.log index
      size = $(this).data("size").split("x")

      # create slide object
      item =
        src: $(this).attr 'href'
        w: parseInt(size[0], 10)
        h: parseInt(size[1], 10)
        msrc: $(this).find('img').attr("src")
        title: $(this).data('caption')
      photoswipeItems.push item

    # Pass data to PhotoSwipe and initialize it
    gallery = new PhotoSwipe(pswpElement, PhotoSwipeUI_Default, photoswipeItems, options)
    gallery.init()
    return


  items.each (index)->
    self = $(this)
    self.on 'click', (e) ->
      e.preventDefault()
      openPhotoSwipe index, $(this), false

  hashData = photoswipeParseHash()
  openPhotoSwipe hashData.pid - 1, items[hashData.gid - 1], true  if hashData.pid > 0 and hashData.gid > 0


