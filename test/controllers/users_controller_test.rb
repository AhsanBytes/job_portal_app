require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:candidate1)
    @job = jobs(:se)
    @admin = users(:admin)
    sign_in @admin
  end

  test "show most recent job" do
    get user_path(@user)

    assert_response :success
    assert_match @job.title, response.body
  end
end
