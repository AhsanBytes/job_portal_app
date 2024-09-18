class Department < ApplicationRecord
  validates :dep_name, presence: true
  validates :dep_name, uniqueness: true

  has_many :jobs
end
