class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { candidate: 0, admin: 1 }

  validate :resume_presence, :resume_format, if: -> { candidate? && resume.blank? }
  validates :name, presence: true, length: { maximum: 50 }
  validates :phone_no, presence: true, 
    format: { with: /\A\+?\d[\d\s]*\z/, message: "must be a valid phone number" },
    length: { in: 10..15, message: "must be between 10 and 15 digits" }
 
  has_many :user_jobs
  has_many :jobs, through: :user_jobs

  has_one_attached :resume

  private

  def resume_presence
    errors.add(:resume, "must be attached")
  end

  def resume_format
    errors.add(:resume, "must be a PDF") unless resume.content_type.in?(%w(application/pdf))
  end
end
