require "test_helper"

class QrUsagesControllerTest < ActionDispatch::IntegrationTest
  test "should get check_usage" do
    get qr_usages_check_usage_url
    assert_response :success
  end
end
