require "test_helper"

class JobTest < ActiveSupport::TestCase
  def setup
    @job = jobs(:se)
  end

  test "job can't be created without title" do
    @job.title = ''
    assert_not @job.valid?, 'Job can not be valid without title'
  end

  test "job can't be created without description" do
    @job.description = nil
    assert_not @job.valid?, 'Job can not be valid without description'
  end

  test "job can't be created without company" do
    @job.company = ''
    assert_not @job.valid?, 'Job can not be valid without company'
  end

  test "job can't be created without work space type" do
    @job.work_space_type = ''
    assert_not @job.valid?, 'Job can not be valid without work space type'
  end

  test "job can't be created without location" do
    @job.location = ''
    assert_not @job.valid?, 'Job can not be valid without location'
  end

  test "job can't be created without creator Id" do
    @job.creator_id = ''
    assert_not @job.valid?, 'Job can not be valid without creator_id'
  end

  test "job can't be created without lead source" do
    @job.lead_source = ''
    assert_not @job.valid?, 'Job can not be valid without lead source'
  end

  test "job title must be unique" do
    @job.save
    duplicate_job = Job.new(
      title: "Software Engineer",
      company: "TechieMinions",
      work_space_type: 0,
      location: "Lahore",
      lead_source: "LinkedIn",
      active: true,
      creator: users(:admin),
      department: departments(:it)
    )
    duplicate_job.save
    assert_not duplicate_job.valid?, 'Duplicate job title should be invalid'
  end

  test 'job has_many applicants' do
    assert_respond_to @job, :applicants, 'Jobs dont have has_many association with applicants'
  end

  test 'job has_many job_skills' do
    assert_respond_to @job, :job_skills, 'Jobs dont have has_many association with job_skills'
  end

  test 'job has_many users through applicants' do
    assert_respond_to @job, :users, 'Jobs dont have has_many association with users'
  end

  test 'job has_many skills through job_skills' do
    assert_respond_to @job, :skills, 'Jobs dont have has_many association with skills'
  end

  test 'job belongs_to department_id (Department)' do
    assert_respond_to @job, :department, "Job don't have associated department"
  end

  test 'job belongs_to creator (User)' do
    assert_respond_to @job, :creator, "Job don't have associated creator"
  end
end
