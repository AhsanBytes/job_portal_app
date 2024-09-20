require "test_helper"

class JobPartialTest < ActionView::TestCase
  test "renders a link to itself" do
    # department = departments(:it)
    # admin = users(:admin)
    job = Job.create! title: "Hello, world", description: "this is testing the rich text and jobs creating functionality",
    company: "Techie", work_space_type: 1, location: "Lahore", 
    lead_source: "linkedin", active: true, department_id: 1, 
    creator_id: 1

    render "jobs/form", job: job

    assert_includes rendered, job.title
  end
end
