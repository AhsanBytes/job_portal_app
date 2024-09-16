class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { candidate: 0, admin: 1 }

  validate :resume_presence
  validate :resume_format
  validates :name, presence: true, length: { maximum: 100 }
  validates :phone_no, presence: true, format: { with: /\A\+?[\d\s]+\z/, message: "must be a valid phone number" }
  validates :role, presence: true, inclusion: { in: roles.keys }

  has_many :user_jobs
  has_many :jobs, through: :user_jobs

  has_one_attached :resume

  private

  def resume_presence
    errors.add(:resume, "must be attached") unless resume.attached?
  end

  def resume_format
    if resume.attached? && !resume.content_type.in?(%w(application/pdf))
      errors.add(:resume, "must be a PDF")
    end
  end
end
