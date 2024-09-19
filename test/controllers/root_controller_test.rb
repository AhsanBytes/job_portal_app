require "test_helper"

class RootControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
  end

  test "user can sign_in" do
    get jobs_path
    assert_response :redirect
    assert_redirected_to new_user_session_path

    user = users(:candidate1)
    sign_in user
    get jobs_path
    assert_response :success
  end
end

