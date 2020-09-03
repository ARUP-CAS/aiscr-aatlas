require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test 'index' do
    10.times { create(:place) }
    get :index
    assert_response :success
  end
end
