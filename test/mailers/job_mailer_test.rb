require "test_helper"

class JobMailerTest < ActionMailer::TestCase
  def setup
    @user =  users(:candidate1)
    @job = jobs(:se)
    @mail = JobMailer.application_confirmation(@user, @job)
  end

  test "should have correct email subject" do
    assert_equal 'Job Application Confirmation', @mail.subject
  end

  test "should be sent to correct emial address" do
    assert_equal [@user.email], @mail.to
  end

  test "should be sent from correct email address" do
    assert_equal ['no-reply@job-portal.com'], @mail.from
  end

  test "should includes the job title in email body" do
    assert_includes @mail.body.encoded, @job.title
  end

  test "should includes the user name in email body" do
    assert_includes @mail.body.encoded, @user.name
  end
end
