# -*- coding: utf-8 -*-
class HomeController < ApplicationController
  def index
    @menu = "home"
    @sample_places = Place.order('random()').limit(5)
  end

  def sources
    @menu = "sources"
    @title = I18n.t('nav.sources')
  end

  def about
    @menu = "about"
    @title = I18n.t('nav.about')
  end

  def downloads
    @menu = "downloads"
    @title = I18n.t('nav.downloads')

    if I18n.locale == :cs
      key = 'data/downloads.cs.yml'
    else
      key = 'data/downloads.en.yml'
    end

    @downloads = YAML::load_file(Rails.root.join(key))
  end
end
