require 'test_helper'

class Admin::MediaPlacementsControllerTest < ActionController::TestCase
  setup do
    @media_placement = create(:media_placement)
    sign_in create(:user)
  end

  test "index" do
    get :index, ids: [@media_placement.id]
    assert_response :success
    assert_equal 1,json[:media_placements].size
  end

  test "update" do
    attrs = attributes_for(:media_placement).merge(title_cs: 'Other', media_item_attributes: { id: @media_placement.media_item.id, copyright_cs: "Autor"})
    patch :update, id: @media_placement, media_placement: attrs
    assert_response :success, response.body.to_s
    
    assert_equal "Autor", @media_placement.reload.media_item.copyright_cs
    assert_equal 'Other', @media_placement.reload.title_cs
  end

  test "destroy" do
    assert_difference('MediaPlacement.count', -1) do
      delete :destroy, id: @media_placement
      assert_response :success, response.body.to_s
    end
  end
end
