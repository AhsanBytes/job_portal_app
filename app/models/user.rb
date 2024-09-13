class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {candidate: 0, admin: 1, hr: 2}

  validates :name, presence: true, length: { maximum: 100 }
  validates :phone_no, presence: true, format: { with: /\A\+?[\d\s]+\z/, message: "must be a valid phone number" }
  validates :role, presence: true, inclusion: { in: roles.keys }

  has_many :jobs, foreign_key: :created_by_id, dependent: :destroy
  has_many :job_applicants
  has_many :applied_jobs, through: :job_applicants, source: :job

  has_one_attached :resume
end
