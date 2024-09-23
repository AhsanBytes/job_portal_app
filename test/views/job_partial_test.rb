require "test_helper"

class JobPartialTest < ActionView::TestCase
  def setup
    @department = departments(:it)
    @admin = users(:admin)
    @job = Job.create!(
      title: "Hello, world",
      description: "this is testing the rich text and jobs creating functionality",
      company: "Techie",
      work_space_type: 1,
      location: "Lahore", 
      lead_source: "linkedin",
      active: true,
      department_id: @department.id, 
      creator_id: @admin.id
    )
  end

test "renders edit link for admin" do
    render partial: "jobs/job", locals: { job: @job, current_user: @admin }

    assert_includes rendered, 'Edit'
  end
end
