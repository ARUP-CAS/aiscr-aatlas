# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require bootstrap-sass/assets/javascripts/bootstrap/transition
#= require bootstrap-sass/assets/javascripts/bootstrap/collapse
#= require bootstrap-sass/assets/javascripts/bootstrap/carousel
#= require bootstrap-sass/assets/javascripts/bootstrap/tab
#= require photoswipe/dist/photoswipe
#= require photoswipe/dist/photoswipe-ui-default
#= require isotope/dist/isotope.pkgd
#= require imagesloaded/imagesloaded.pkgd
#= require ./map
#= require ./photoswipe.init
#= require_directory ./google-maps-utility

$ ->
  $wrapper = $('#wrapper')
  $map = $('#section-map')
  $content = $('#section-content')

  # Isotope
  $container = $('[data-isotope]')
  initMasonry = ->
    $container.imagesLoaded ->
      $container = $container.isotope
        layoutMode: "masonry"
        itemSelector: '.item'
        gutter: 0

  $('[data-toggle-map]').on 'click', (e)->
    e.preventDefault()
    if $wrapper.hasClass 'map-only'
      $wrapper.removeClass 'map-only'
    else
      $wrapper.addClass 'map-only'

  $('[data-slideshow]')
    .carousel
      interval: 8000
      pause: false
    .on 'slid.bs.carousel', ->
      id = $(this).find('.active').data 'slide-no'
      # console.log $("[data-carousel-id=#{ $(this).attr('id') }]")
      $("[data-carousel-id=#{ $(this).attr('id') }]").find("[data-slide-to=#{ id }]").addClass('active').siblings().removeClass('active')



  # Tags filtering
  $('[data-tag]').on 'click', (e) ->
    e.preventDefault()
    $(this).toggleClass 'active'

    tags = $(this).parents('[data-url]').first()

    url = tags.data 'url'
    vars = "?"

    tags.find('[data-tag].active').each ->
      vars += "tags[]=#{$(this).data('tag')}&"

    $('.spinner-placeholder').html('<div class="spinner"></div>')

    $.get(url+vars)


  $('[data-hide-on-click]').on 'click', ->
    $(this).hide()

  $('[data-show-tags]').on 'click', (e) ->
        e.preventDefault()
        $(this).hide()
        $(this).parents('.filter').find('[data-tag]').removeClass 'hidden'

  initPhotoSwipeFromDOM $ "[data-gallery]"
  $(window).on 'load', ->
    initMasonry()

    $('a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
      # e.target
      $container.isotope 'layout'
