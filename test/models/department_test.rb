require "shoulda/matchers"


class DepartmentTest < ActiveSupport::TestCase
  test '#jobs' do
    assert_equal 2, Department.count
  end
end
