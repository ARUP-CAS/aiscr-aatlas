# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    @query = params[:q]
    @title = t('search.breadcrumb', query: @query)

    @places = Place.search(@query).page(params[:page]).per(10)
    @pagination = true
  end
end
