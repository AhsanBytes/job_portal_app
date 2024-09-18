require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:candidate1)
  end

  test 'devise has authenticatable module' do
    assert_includes @user.devise_modules, :database_authenticatable, "devise don't have authenticatable module"
  end

  test 'devise has registerable module' do
    assert_includes @user.devise_modules, :registerable, "devise don't have registerable module"
  end

  test 'devise has recoverable module' do
    assert_includes @user.devise_modules, :recoverable, "devise don't have recoverable module"
  end

  test 'devise has rememberable module' do
    assert_includes @user.devise_modules, :rememberable, "devise don't have rememberable module"
  end

  test 'devise has validatable module' do
    assert_includes @user.devise_modules, :validatable, "devise don't have validateable module"
  end

  test 'candidate has role' do
    candidate_user = users(:candidate1)
    assert_equal candidate_user.role, "candidate", "enum role don't have correct value for candidate"
  end

  test 'admin has role' do
    admin_user = users(:admin)
    assert_equal admin_user.role, "admin", "enum role don't have correct value for admin"
  end

  test 'name must be present' do
    @user.name = ''
    assert_not @user.valid?, "name can't be blank"
  end

  test 'name max length is fifty' do
    @user.name = 'a' * 51
    assert_not @user.valid?, "name max length is fifty"
  end

  test 'phone number must be present' do
    @user.phone_no = ''
    assert_not @user.valid?, "User phone_no can't be blank"
  end

  test "should be valid with correct phone number" do
    @user.phone_no = "+923132132323"
    assert_not @user.valid?
  end

  test "should not be valid with too short phone number" do
    @user.phone_no = "123"
    assert_not @user.valid?, "must be between 10 and 15 digits"
  end

  test "should not be valid with too long phone number" do
    @user.phone_no = "+1234567890123456"
    assert_not @user.valid?, "must be between 10 and 15 digits"
  end

  test "should not be valid with invalid phone number format" do
    @user.phone_no = "abc1234567"
    assert_not @user.valid?, "must be a valid phone number without alphabets"
  end

  test "should be valid with spaces in phone number" do
    @user.phone_no = "+92 313 2132323"
    assert_not @user.valid?
  end

  test 'user has_many user_jobs' do
    assert_respond_to  @user, :user_jobs, "User don't have user_jobs association"
  end

  test 'user has_many jobs through user_jobs' do
    assert_respond_to @user, :jobs, "User don't have jobs through user_jobs association"
  end
end
