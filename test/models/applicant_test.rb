require "test_helper"

class ApplicantTest < ActiveSupport::TestCase
  def setup
    @applicant = applicants(:candidate1_se)
  end

  test "UserJob belongs to user" do
    assert_respond_to @applicant, :user, "Userjob don't belongs to user"
  end

  test "UserJob belongs to job" do
    assert_respond_to @applicant, :job, "Userjob don't belongs to job"
  end

  test "User can apply on job once" do
    user = users(:candidate1)
    job = jobs(:se)
    apply_again = Applicant.new(user_id: user.id, job_id: job.id)
    assert_not apply_again.valid?
    assert_equal 'User have already applied for job', apply_again.errors.full_messages.to_sentence
  end
end
