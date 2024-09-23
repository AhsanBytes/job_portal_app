require 'application_system_test_case'

class AdminFunctionalitySystemTest < ApplicationSystemTestCase
  def setup
    @admin = users(:admin)
    @department = departments(:it)
    @skill = skills(:html)
  end

  test 'admin can create job' do
    sign_in @admin
    visit jobs_path

    click_on "New Job"

    fill_in 'Title', with: 'Creating a Job'
    find('#job_description').set('text')
    fill_in 'Company', with: 'TechieMinions'
    
    choose 'job_work_space_type_onsite'
    
    fill_in 'Location', with: 'remote'
    fill_in 'Lead source', with: 'INdeed'
    
    check 'job_active'
    select @department.name, from: 'job[department_id]'
    check @skill.name
    
    click_on "Create Job"
    assert_text "Job successfully created."
  end
end
