class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {candidate: 0, admin: 1, hr: 2}

  has_one_attached :resume
  has_many :jobs, foreign_key: :created_by_id, dependent: :destroy  
  has_many :job_applicants
  has_many :applied_jobs, through: :job_applicants, source: :job 

  validates :name, presence: true, length: { maximum: 100 }
  validates :phone_no, presence: true, format: { with: /\A\+?[\d\s]+\z/, message: "must be a valid phone number" }
  validates :role, presence: true, inclusion: { in: roles.keys }
  validate :resume_type
  validate :resume_size

  private

  def resume_type
    return unless resume.attached?
    
    acceptable_types = ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']
    unless acceptable_types.include?(resume.content_type)
      errors.add(:resume, 'must be a PDF or a Word document')
    end
  end

  def resume_size
    return unless resume.attached?
    
    if resume.byte_size > 5.megabytes
      errors.add(:resume, 'should be less than 5MB')
    end
  end
end
