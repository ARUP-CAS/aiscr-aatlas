require 'test_helper'

class PlacesControllerTest < ActionController::TestCase
  test 'markers' do
    10.times { create(:place) }
    get :markers, locale: :cs
    assert_response :success
    assert_equal 10,json[:markers].size
  end
end
