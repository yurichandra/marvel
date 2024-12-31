class UserFollow < ApplicationRecord
  belongs_to :follower, class: User
  belongs_to :following, class: User
end