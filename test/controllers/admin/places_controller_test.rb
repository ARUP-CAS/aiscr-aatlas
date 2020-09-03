require 'test_helper'

class Admin::PlacesControllerTest < ActionController::TestCase
  setup do
    @place = create(:place)
    @user = create(:user)
    sign_in @user
  end

  test "index" do
    get :index
    assert_response :success
    assert_equal 1,json[:places].size
  end

  test "create" do
    assert_difference('Place.count') do
      post :create, place: attributes_for(:place)

      assert_response :success, response.body.to_s
      assert_not_nil json[:place]
    end
  end

  test "update" do
    patch :update, id: @place.id, place: attributes_for(:place)
    assert_response :success, response.body.to_s
  end

  test "destroy" do
    assert_difference('Place.count', -1) do
      delete :destroy, id: @place.id
      assert_response :success, response.body.to_s
    end
  end

  test "authentication" do
    sign_out @user
    get :index
    assert_redirected_to '/users/sign_in'
  end
end
