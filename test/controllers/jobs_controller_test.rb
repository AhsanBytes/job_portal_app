require "test_helper"

class JobsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:candidate2)
    @admin = users(:admin)
  end

  test "admin index" do
    sign_in @admin
    assert :success
  end

  test "candidate index" do
    job1 = jobs(:se)
    sign_in @user
    get jobs_url, params: { search: 'Engineer' }
    assert_response :success
    assert_match job1.title, response.body
  end

  test "create a new job" do
    department = departments(:it)
    sign_in @admin
    assert_difference("Job.count") do
      post jobs_url, params: 
      { 
        job: 
          {
            title: 'Marketing',
            description: "this is testing the rich text and jobs creating functionality",
            company: "Techie",
            work_space_type: "onsite",
            location: "Lahore",
            lead_source: "linkedin",
            active: true,
            department_id: department.id,
            creator_id: @admin.id
          }
      }
    end

    assert_redirected_to jobs_path
    assert_equal 'Job successfully created.', flash[:notice]
  end

  test "candidate can apply for a job" do
    @job = jobs(:se)
    sign_in @user
    assert @user.user_jobs.new(job: @job).valid?
    post apply_job_path(@job)
    assert_equal flash[:notice], 'Successfully applied for the job.'
    assert_redirected_to jobs_path
  end

  test "candidate can't apply for a job mutliple times" do
    @job = jobs(:se)
    sign_in @user
    assert @user.user_jobs.new(job: @job).valid?
    post apply_job_path(@job)
    assert_equal flash[:notice], 'Successfully applied for the job.'
    assert_redirected_to jobs_path

    assert_not @user.user_jobs.new(job: @job).valid?
    post apply_job_path(@job)
    assert_equal 'You are not authorized to perform this action.', flash[:alert]
    assert_redirected_to root_path
  end
end
