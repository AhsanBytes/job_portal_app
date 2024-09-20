require "test_helper"

class JobsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:candidate2)
    @admin = users(:admin)
  end

  test "admin index" do
    sign_in @admin
    get jobs_path
  end

  test "candidate index" do
    sign_in @user
    get jobs_path

    post jobs_url, params: { job: { title: 'Marketing' } }
    assert_equal jobs.count, 2
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
    assert_equal "Job successfully created.", flash[:notice]
  end

  test "candidate can apply for job" do
    @job = jobs(:se)
    sign_in @user
    assert @user.user_jobs.new(job: @job).valid?
    post apply_job_path(@job)
    assert_redirected_to root_path
  end
end
