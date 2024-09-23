require 'application_system_test_case'

class AdminFunctionalitySystemTest < ApplicationSystemTestCase
  def setup
    @admin = users(:admin)
    
    # Ensure there are departments available
    @department = Department.create(name: 'IT')
  end

  test 'admin can create job' do
    sign_in @admin
    visit jobs_path

    click_on "New Job"

    fill_in 'Title', with: 'Creating a Job'
    fill_in 'Company', with: 'TechieMinions'
    
    choose 'job_work_space_type_onsite'
    
    fill_in 'Location', with: 'remote'
    fill_in 'Lead source', with: 'INdeed'
    
    check 'job_active'
    
    # Select the department from the created department
    select @department.name, from: 'job[department_id]'
    
    click_on "Create Job"
  
    assert_text "Job created successfully"
  end
end
