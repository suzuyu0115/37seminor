require 'rails_helper'

RSpec.describe Quest, type: :model do
  describe 'バリデーションテスト' do
    it 'すべてのカラムにデータを入れた場合' do
      quest = build(:quest)
      expect(quest).to be_valid
      expect(quest.errors).to be_empty
    end

    it "titleがない場合" do
      user = build(:quest, title: "")
      expect(quest).to be_invalid
      # expect(user.errors[:name]).to eq ["can't be blank"]
    end
  end
end