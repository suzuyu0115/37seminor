class Join < ApplicationRecord
  belongs_to :user
  belongs_to :quest

  validates :user_id, presence: true, uniqueness: { scope: :quest_id }
end
