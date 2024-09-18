class Skill < ApplicationRecord
  validates :skill_name, presence: true

  has_many :job_skills
  has_many :jobs, through: :job_skills
end
