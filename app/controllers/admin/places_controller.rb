class Admin::PlacesController < Admin::PagesController

  def pages
    Place
  end

  def serializer
    Admin::PlaceSerializer
  end

  def params_require
    params.require(:place)
  end

  def permitted_attributes
    super.unshift(:address,:longitude,:latitude)
  end


end
