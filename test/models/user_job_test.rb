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

  test "User can apply on job once" do
    user = users(:candidate1)
    job = jobs(:se)
    debugger
    apply_again = UserJob.new(user_id: user.id, job_id: job.id)
    assert apply_again.valid?
    assert_equal 'User have already applied for job', apply_again.errors.full_messages.to_sentence
  end
end
