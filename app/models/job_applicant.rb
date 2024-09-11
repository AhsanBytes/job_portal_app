class JobApplicant < ApplicationRecord
  belongs_to :user
  belongs_to :job
  has_one_attached :resume
end
