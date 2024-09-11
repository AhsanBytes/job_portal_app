class Job < ApplicationRecord
  belongs_to :department
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id
  
  has_many :job_applicants, dependent: :destroy
  has_many :applicants, through: :job_applicants, source: :user

  has_many :job_skills, dependent: :destroy
  has_many :skills, through: :job_skills
end
