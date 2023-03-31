class Quest < ApplicationRecord
  belongs_to :user
  has_many :joins, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :step, presence: true
  validates :body, presence: true, length: { maximum: 65535 }
  validates :place, presence: true, length: { maximum: 255 }

  enum step: { introduction: 0, basic: 1, advanced: 2, other: 3 }
  enum state: { not_completed: 0, completed: 1 }
end
