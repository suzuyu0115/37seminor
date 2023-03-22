class Quest < ApplicationRecord
  belongs_to :user

  enum step: { introduction: 0, basic: 1, advanced: 2, other: 3 }
end
