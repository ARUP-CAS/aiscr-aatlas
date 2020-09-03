require 'test_helper'

class QrControllerTest < ActionController::TestCase
  test 'show' do
    place = create(:place, qr_id: '88a66', slug: 'albrechtice')
    get :show, id: '88a66'
    assert_redirected_to 'http://archeologickyatlas.cz/en/lokace/albrechtice'
  end
end
