require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:candidate1)
  end

  test 'devise has authenticatable, registerable, recoverable, rememberable, validatable module' do
    assert_includes @user.devise_modules, :database_authenticatable, "devise don't have authenticatable module"
    assert_includes @user.devise_modules, :registerable, "devise don't have registerable module"
    assert_includes @user.devise_modules, :recoverable, "devise don't have recoverable module"
    assert_includes @user.devise_modules, :rememberable, "devise don't have rememberable module"
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
    @user.phone_no = "0313213 2323"
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
    @user.phone_no = "+92 3132132323"
    assert_not @user.valid?
  end

  test 'user has_many user_jobs' do
    assert_respond_to  @user, :user_jobs, "User don't have user_jobs association"
  end

  test 'user has_many jobs through user_jobs' do
    assert_respond_to @user, :jobs, "User don't have jobs through user_jobs association"
  end

  test 'candidate must have resume attached' do
    @user.resume.detach
    assert_not @user.valid?
    assert_includes @user.errors.full_messages, "Resume must be attached"
  end

  test 'candidate resume must be a PDF' do
    @user.resume.attach(
      io: File.open(Rails.root.join('test', 'fixtures', 'files', 'invalid_resume.png')),
      filename: 'invalid_resume.png',
      content_type: 'text/plain'
    )
    assert_not @user.valid?
    assert_includes @user.errors.full_messages, "Resume must be a PDF"
  end

  test 'admin does not require a resume' do
    admin = users(:admin)
    admin.resume.detach
    assert admin.valid?
  end

  test 'candidate with a valid PDF resume should be valid' do
    @user.resume.attach(
      io: File.open(Rails.root.join('test', 'fixtures', 'files', 'resume.pdf')),
      filename: 'resume.pdf',
      content_type: 'application/pdf'
    )
    assert @user.valid?, 'Candidate should be valid with a PDF resume'
  end
end
