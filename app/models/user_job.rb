class UserJob < ApplicationRecord
  before_save :attach_resume

  validates :user_id, uniqueness: { scope: :job_id, message: "have already applied for job" }

  belongs_to :user
  belongs_to :job
  
  has_one_attached :resume

  private

  def attach_resume
    resume_blob = user.resume.blob
    resume.attach(resume_blob)
  end
end
