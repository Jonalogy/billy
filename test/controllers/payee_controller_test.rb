require 'test_helper'

class PayeeControllerTest < ActionDispatch::IntegrationTest
  test "should get verify_mobile" do
    get payee_verify_mobile_url
    assert_response :success
  end

end
