require 'test_helper'

class ReadControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get read_index_url
    assert_response :success
  end

end
