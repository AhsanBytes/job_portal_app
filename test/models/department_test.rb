require "test_helper"

class DepartmentTest < ActiveSupport::TestCase
  def setup
    @dep = departments(:it)
  end

  test 'should be valid with a name' do
    assert @dep.valid?
  end

  test 'should not be valid without a name' do
    @dep.dep_name = nil
    assert_not @dep.valid?, 'Department is valid without a name'
  end

  test 'should not allow duplicate department names' do
    @dep.save
    duplicate_dep = Department.new(dep_name: 'IT')
    duplicate_dep.save
    assert_not duplicate_dep.valid?, 'Duplicate department name should be invalid'
  end

  test 'should have many jobs' do
    assert_respond_to @dep, :jobs, 'Department dont have has_many association with job'
  end

  test 'should not allow empty department name' do
    @dep.dep_name = ''
    assert_not @dep.valid?, 'Department is invalid with an empty name'
  end
end
