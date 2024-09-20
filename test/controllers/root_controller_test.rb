require "test_helper"

class RootControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:candidate1)
  end
  test "should get home" do
    get root_url
    assert_response :success
  end

  test "user can sign_in and sign_out" do
    get jobs_path
    assert_response :redirect
    assert_redirected_to new_user_session_path

    sign_in @user
    get jobs_path
    assert_response :success

    sign_out @user
    assert_response :success
  end
end
