require "test_helper"

class SkillTest < ActiveSupport::TestCase
  def setup
    @skill = skills(:html)
  end

  test "skill name can't be blank" do
    @skill.name = ''
    assert_not @skill.valid?, 'skill name should not be blank'
  end

  test "skill has_many job_skills" do
    assert_respond_to @skill, :job_skills, 'skill must have job_skills association'
  end

  test "skill has_many jobs through job_skills" do
    assert_respond_to @skill, :jobs, 'skill must have jobs through jb_skills association'
  end
end
