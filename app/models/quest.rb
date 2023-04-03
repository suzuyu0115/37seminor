class Quest < ApplicationRecord
  belongs_to :user
  has_many :joins, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :step, presence: true
  validates :body, presence: true, length: { maximum: 65535 }
  validates :place, presence: true, length: { maximum: 255 }

  enum step: { introduction: 0, basic: 1, advanced: 2, other: 3 }
  enum state: { not_completed: 0, completed: 1 }

  # クエストが"completed"のstateを持つ場合にはfalseを返し、それ以外の場合にはtrueを返すメソッド
  def editable?
    !completed?
  end
end
