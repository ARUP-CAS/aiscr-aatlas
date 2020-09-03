class QrController < ApplicationController

  def show
    @place = Place.find_by_qr_id!(params[:id])
    set_locale
    redirect_to place_url(@place, host: 'archeologickyatlas.cz', locale: I18n.locale), status: 301
  end

  private

  def set_locale
    to_locale = extract_locale_from_accept_language_header
    if to_locale.to_s == "cs"
      I18n.locale = to_locale
    else
      I18n.locale = :en
    end
  end

  def extract_locale_from_accept_language_header
    if accept = request.env['HTTP_ACCEPT_LANGUAGE']
      accept.scan(/^[a-z]{2}/).first
    end
  end

end
