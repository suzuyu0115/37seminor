class Quest < ApplicationRecord
  belongs_to :user

  enum_role: { introduction: 0, basic: 1, advanced: 2, other: 3 }
end
