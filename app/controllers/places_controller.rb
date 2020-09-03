# -*- coding: utf-8 -*-
require 'ostruct'
require 'open-uri'

class PlacesController < ApplicationController
  ERAS = [
    'pravěk',
    'raný středověk',
    'vrcholný/pozdní středověk',
    'novověk',
    'industriální období/současnost',
  ]

  before_filter :set_menu
  respond_to :js, :html

  def index
    @title = "Seznam lokací"

    filtered = Place.includes(:media_placements).ordered

    @pagination = true
    tags = params[:tags]

    if tags.present?
      tags = tags.join(", ")
      @places = filtered.tagged_with(tags)
      @pagination = false
    else
      @places = filtered.page(params[:page]).per(22)
    end

    @tags_type = ActsAsTaggableOn::Tag.where(era: false).order("title_#{I18n.locale} ASC")
    @tags_era = ActsAsTaggableOn::Tag.where(era: true).order("title_#{I18n.locale} ASC")

    if request.xhr?
      respond_to do |format|
        format.js {render :layout => !request.xhr?}
      end
    else
      respond_to do |format|
        format.html {}
      end
    end
  end

  def show
    @place = Place.find_by_slug(params[:id]) || Place.find(params[:id])
    # TODO - move these to model
    @title = @place.meta_title || @place.title
    @description = @place.text_content
    @fb_image = @place.cover_image.thumb("1200x630#").url if @place.cover_image

    respond_to do |format|
      format.html
      format.pdf { render_pdf(@place) }
    end
  end

  def markers
    if stale?(last_modified: Place.last_update)
      markers = Place.with_coordinates.all.map do |place|
        image =  cover(place)

        {
          id: place.id,
          title: place.title,
          subtitle: place.subtitle,
          latitude: place.latitude,
          longitude: place.longitude,
          image_url: image.url,
          image_height: image.height,
          place_url: place_path(place)
        }
      end

      render json: markers, root: 'markers'
    end
  end

  private

  def cover(place)
    place.cover_image.thumb("190x70#")
  rescue
    OpenStruct.new(url: 'http://placehold.it?190x70', height: 70)
  end

  def set_menu
    @menu = "places"
  end

  def render_pdf(place)
    printer = PlacePrinter.new(place, place_url(place))

    send_data printer.print,
              filename: printer.pdf_name,
              type: 'application/pdf',
              disposition: 'inline'
  end
end
