require "test_helper"

class JobApplicantsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get job_applicants_create_url
    assert_response :success
  end
end
