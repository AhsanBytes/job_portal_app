require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:candidate1)
  end

  test "show most recent job" do
    sign_in @user
    assert @user.user_jobs.order(created_at: :desc).first.valid?
  end
end
