class Like < ApplicationRecord
  belongs_to :user
  belongs_to :log
  validates  :user_id, presence: true
  validates  :log_id,  presence: true
end
