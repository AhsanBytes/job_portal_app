require 'application_system_test_case'

class AdminFunctionalitySystemTest < ApplicationSystemTestCase
  def setup
    @admin = users(:admin)
  end
  test 'admin can create job' do
    sign_in @admin
    visit jobs_path(@admin)

    click_on "New Job"

    fill_in 'Title', with: 'Creating a Job'
    fill_in 'Company', with: 'TechieMinions'
    fill_in 'work_space_type', with: 'onsite'
    fill_in 'location', with: 'remote'
    fill_in 'lead_source', with: 'INdeed'
    fill_in 'active', with: true
    fill_in 'creator', with: 'admin'
    fill_in 'department', with: 'it'
  
    click_on "Create Job"
  
    assert_text "JOb created successfully"
  end
end