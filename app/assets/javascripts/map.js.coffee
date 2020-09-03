
map = undefined
mapMarkers = []
mapMarkersByIds = []
trigger = false

initialize = ->
  $.get $("#map").data("url"), (data) =>
    markers = data.markers

    roadAtlasStyles = [{"elementType":"labels.text.fill","featureType":"administrative","stylers":[{"color":"#ffffff"}]},{"elementType":"labels.text.stroke","featureType":"administrative","stylers":[{"lightness":"-24"},{"invert_lightness":true},{"gamma":"1.22"},{"saturation":"-100"}]},{"elementType":"geometry.fill","featureType":"landscape.man_made","stylers":[{"saturation":"-100"},{"lightness":"-18"}]},{"elementType":"geometry.fill","featureType":"landscape.natural","stylers":[{"hue":"#00ffc1"},{"saturation":"-65"},{"gamma":"0.82"}]},{"elementType":"geometry.fill","featureType":"poi.park","stylers":[{"hue":"#00ff8d"},{"saturation":"-58"}]},{"elementType":"geometry.fill","featureType":"road","stylers":[{"color":"#ffffff"}]},{"elementType":"labels.icon","featureType":"road","stylers":[{"saturation":"-100"},{"lightness":"-9"},{"visibility":"off"}]},{"elementType":"geometry.stroke","featureType":"road.highway","stylers":[{"color":"#7c928d"}]},{"elementType":"geometry.fill","featureType":"water","stylers":[{"saturation":"-71"},{"hue":"#00f5ff"},{"lightness":"-29"}]}]
    infowindow = new google.maps.InfoWindow()
    bounds = new google.maps.LatLngBounds()

    mapOptions =
      zoom: 5
      maxZoom: 12
      minZoom: 6
      mapTypeControl:false
      # disableDefaultUI: true
      mapTypeControlOptions:
        mapTypeIds: [
          google.maps.MapTypeId.ROADMAP
        ]
    map = new (google.maps.Map)(document.getElementById('map'), mapOptions)

    styledMapOptions = name: "Archatlas"
    roadMapType = new google.maps.StyledMapType(roadAtlasStyles, styledMapOptions)
    map.mapTypes.set "cr", roadMapType
    map.setMapTypeId "cr"

    # Setup markers
    for marker in markers
      latlng = new (google.maps.LatLng)(marker.latitude,marker.longitude)

      contentString =
            "<div id='#{marker.id}' class='popup-window'>"+
              "<p><a href='#{marker.place_url}'>#{marker.title}</a></p>"+
              "<p class='small' style='max-width:250px;'><small>#{marker.subtitle}</small></p>"+
              "<a href='#{marker.place_url}'><img class='fill-horizontal indent-top-thin' src='#{marker.image_url}' height='#{marker.image_height}' /></a>"+
              "<p class='small indent-top-thin'><a class='small' href='#{marker.place_url}'>#{ $("#map").data("more") }</a></p>"+
            "</div>";
      infobox = new InfoBox
        content: contentString
        disableAutoPan: false
        alignBottom: true
        # maxWidth: 300
        pixelOffset: new google.maps.Size(0, 0)

      m = new MarkerWithLabel
        id: marker.id
        map:      map
        position: latlng
        content:  contentString
        icon: icons['default'].icon
        labelAnchor: new google.maps.Point(18, 34)
        labelClass: "marker-label"
        labelInBackground: false
        image_url: marker.image_url

      mapMarkersByIds[marker.id] = m
      mapMarkers.push(m)
      bounds.extend(latlng)

      google.maps.event.addListener m, 'click', ->
        self = this
        image = new Image()
        infobox.close()
        if !trigger
          infobox.setContent self.content
          infobox.open(map, self);
        $(image).load ->
          map.setZoom(10);
          map.panTo self.getPosition()
        image.src = self.image_url

        # Active icon
        i = 0
        while i < mapMarkers.length
          mapMarkers[i].setIcon icons['default'].icon
          i++
        self.setIcon icons['large'].icon

        $("[data-marker]").removeClass 'active'
        currentLink = $("[data-marker=#{this.id}]")
        currentLink.addClass 'active'
        trigger = false

    map.fitBounds(bounds)

    google.maps.event.addListener map, 'click', ->
      infobox.close()

    # clusterStyles = [
    #   {
    #     textColor: 'transparent'
    #     url: icons['default'].icon
    #     height: 28
    #     width: 23
    #   }
    #   {
    #     textColor: 'transparent'
    #     url: icons['large'].icon
    #     height: 43
    #     width: 37
    #   }
    # ]
    # options = {
    #   styles: clusterStyles
    # }
    #
    # mc = new MarkerClusterer(map, mapMarkers, options)

    # trigger
    $("[data-marker]").on 'click', ->
      if !trigger && $(window).width() <= 1055
        $('#wrapper').addClass 'map-only'
      trigger = true
      google.maps.event.trigger mapMarkersByIds[$(this).data('marker')], 'click'
      return

    google.maps.event.addListenerOnce map, 'idle', ->
      if showMarker?
        trigger = true
        $("[data-marker]").first().trigger 'click'


    $('#section-map')
      .css
        height: $(window).height()
      .on 'transitionend webkitTransitionEnd oTransitionEnd otransitionend MSTransitionEnd', ->
        center = map.getCenter()
        google.maps.event.trigger map, 'resize'
        map.setCenter center

    return


google.maps.event.addDomListener window, 'load', initialize
