class Job < ApplicationRecord
  enum work_space_type: { onsite: 0, remote: 1, hybrid: 2 }

  validates :title, :description, :company, :work_space_type, :location, :creator_id, :lead_source, presence: true
  validates :title, uniqueness: true

  belongs_to :department
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  has_many :user_jobs, dependent: :destroy
  has_many :users, through: :user_jobs
  has_many :job_skills, dependent: :destroy
  has_many :skills, through: :job_skills
  
  has_rich_text :description

  scope :active, -> { where(active: true) }
  scope :search_by_title, ->(query) {
    where("title LIKE ?", "%#{query}%") if query.present?
  }
end
