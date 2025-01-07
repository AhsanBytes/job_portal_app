require "test_helper"

class JobMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:candidate1)
    @job = jobs(:se)
  end

  test "should send job application confirmation email" do
    assert_emails 0
    JobMailer.application_confirmation(@user, @job).deliver_now
    assert_emails 1

    @mail = ActionMailer::Base.deliveries.last
    assert_equal 'Job Application Confirmation', @mail.subject
    assert_equal [@user.email], @mail.to
    assert_equal ['no-reply@job-portal.com'], @mail.from
    assert_includes @mail.body.encoded, @job.title
    assert_includes @mail.body.encoded, @user.name
  end
end
