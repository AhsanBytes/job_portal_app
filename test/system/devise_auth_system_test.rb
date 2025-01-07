require 'application_system_test_case'

class DeviseAuthSystemTest < ApplicationSystemTestCase
  test 'sign in existing user (admin)' do
    admin = users(:admin)
    visit new_user_session_path
    sign_in admin

    visit jobs_path(admin)
    assert_current_path jobs_path(admin)
  end

  test 'create user and sign in' do
    email = 'candidate1@example.com'
    password = 'password'

    visit new_user_session_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'

    assert_current_path jobs_path
  end
end