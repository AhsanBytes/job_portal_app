class Job < ApplicationRecord
  validates :title, :description, :company, :work_space_type, :location, :lead_source, presence: true
  validates :department_id, presence: true

  belongs_to :department
  belongs_to :creater, class_name: 'User', foreign_key: 'creater_id'
  
  has_many :job_applicants, dependent: :destroy
  has_many :applicants, through: :job_applicants, source: :user

  has_many :job_skills, dependent: :destroy
  has_many :skills, through: :job_skills
  
  has_rich_text :description
end
