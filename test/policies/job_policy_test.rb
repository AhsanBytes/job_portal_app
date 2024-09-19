require 'test_helper'

class JobPolicyTest < ActiveSupport::TestCase
  def setup
    @admin = users(:admin)
    @candidate = users(:candidate1)
    @active_job = jobs(:se)
    @inactive_job = jobs(:pm)
    @admin_policy = JobPolicy.new(@admin, @active_job)
    @candidate_policy = JobPolicy.new(@candidate, @active_job)
  end

  test "admin should be allowed to create a job" do
    assert @admin_policy.create?
  end

  test "admin should be allowed to update a job" do
    assert @admin_policy.update?
  end

  test "admin should be allowed to destroy a job" do
    assert @admin_policy.destroy?
  end

  test "admin should be allowed to show a job" do
    assert @admin_policy.show?
  end

  test "admin should be allowed to apply a job" do
    assert_not @admin_policy.apply?
  end

  test "candidate should not be allowed to create job" do
    assert_not @candidate_policy.create?
  end

  test "candidate should not be allowed to update job" do
    assert_not @candidate_policy.update?
  end

  test "candidate should not be allowed to destroy job" do
    assert_not @candidate_policy.destroy?
  end

  test "candidate should be allowed to show job" do
    assert @candidate_policy.show?
  end

  test "candidate should be allowed to apply job once" do
    assert_not @candidate_policy.apply?
  end

  test "admin can see all active inactive jobs" do
    policy_scope = JobPolicy::Scope.new(@admin, Job).resolve
    assert_includes policy_scope, @active_job
    assert_includes policy_scope, @inactive_job
  end

  test "candidate can see only active jobs" do
    policy_scope = JobPolicy::Scope.new(@candidate, Job).resolve
    assert_includes policy_scope, @active_job
    assert_not_includes policy_scope, @inactive_job
  end
end
