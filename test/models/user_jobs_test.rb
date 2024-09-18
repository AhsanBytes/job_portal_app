require "test_helper"

class UserJobTest < ActiveSupport::TestCase
  def setup
    @user_job = user_jobs(:candidate1_se)
  end

  test "UserJob belongs to user" do
    assert_respond_to @user_job, :user, "Userjob don't belongs to user"
  end

  test "UserJob belongs to job" do
    assert_respond_to @user_job, :job, "Userjob don't belongs to job"
  end
end
