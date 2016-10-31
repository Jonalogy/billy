require 'test_helper'

class FavoursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @favour = favours(:one)
  end

  test "should get index" do
    get favours_url
    assert_response :success
  end

  test "should get new" do
    get new_favour_url
    assert_response :success
  end

  test "should create favour" do
    assert_difference('Favour.count') do
      post favours_url, params: { favour: { contract_id: @favour.contract_id, description: @favour.description, owner_agree: @favour.owner_agree, payee-agree: @favour.payee-agree } }
    end

    assert_redirected_to favour_url(Favour.last)
  end

  test "should show favour" do
    get favour_url(@favour)
    assert_response :success
  end

  test "should get edit" do
    get edit_favour_url(@favour)
    assert_response :success
  end

  test "should update favour" do
    patch favour_url(@favour), params: { favour: { contract_id: @favour.contract_id, description: @favour.description, owner_agree: @favour.owner_agree, payee-agree: @favour.payee-agree } }
    assert_redirected_to favour_url(@favour)
  end

  test "should destroy favour" do
    assert_difference('Favour.count', -1) do
      delete favour_url(@favour)
    end

    assert_redirected_to favours_url
  end
end
