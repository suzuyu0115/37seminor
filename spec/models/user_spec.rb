require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションテスト' do
    it 'すべてのカラムにデータを入れた場合' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it "nameがない場合" do
      user = build(:user, name: nil)
      expect(user).to be_invalid
      expect(user.errors[:name]).to eq ["を入力してください"]
    end

    it "emailがない場合" do
      user = build(:user, email: nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to eq ["を入力してください"]
    end
  end
end