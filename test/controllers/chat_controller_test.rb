require 'test_helper'

class ChatControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get chat_show_url
    assert_response :success
  end

end
