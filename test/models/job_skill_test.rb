require "test_helper"

class JobSkillTest < ActiveSupport::TestCase
  def setup
    @job_skill = job_skills(:se_html)
  end

  test "JobSkill belongs to job" do
    assert_respond_to @job_skill, :job, "job skill don't have job"
  end

  test "JobSkill belongs to skill" do
    assert_respond_to @job_skill, :skill, "job skill don't have skill"
  end
end
