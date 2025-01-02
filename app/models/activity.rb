class Activity < ApplicationRecord
  validates :start_at, presence: true
  belongs_to :user
end