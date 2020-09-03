# coding: utf-8
require 'test_helper'


class PlaceTest < ActiveSupport::TestCase
  test 'compute_coordinates' do
    p = create :place, geo_coordinates: %{N 49°19'09.06", E 14°33'52.37"}
    assert_equal "49.3191833", p.latitude.to_s
    assert_equal "14.5645472", p.longitude.to_s
  end
end

