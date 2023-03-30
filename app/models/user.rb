class User < ApplicationRecord
  has_many :quests, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :join_quests, through: :joins, source: :quest

  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader #カラム名、アップローダー名

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  def own?(object)
    id == object.user_id
  end

  # クエストに参加
  def join(quest)
    join_quests << quest
  end

  # クエスト参加を取り消す
  def unjoin(quest)
    join_quests.destroy(quest)
  end

  # クエスト参加しているか否か判定するメソッド
  def join?(quest)
    join_quests.include?(quest)
  end
end
