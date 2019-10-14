require 'test_helper'

class GearsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get gears_new_url
    assert_response :success
  end

end
