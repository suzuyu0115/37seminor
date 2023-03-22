require 'rails_helper'

RSpec.describe Quest, type: :model do
  describe 'バリデーションテスト' do
    it 'すべてのカラムにデータを入れた場合' do
      quest = build(:quest)
      expect(quest).to be_valid
      expect(quest.errors).to be_empty
    end

    it "titleがない場合" do
      quest = build(:quest, title: "")
      expect(quest).to be_invalid
      expect(quest.errors[:title]).to eq ["を入力してください"]
    end

    context 'titleが255文字以下の場合' do
      it '有効であること' do
        quest = build(:quest, title: 'a' * 255)
        expect(quest).to be_valid
      end
    end
  
    context 'titleが256文字以上の場合' do
      it '無効であること' do
        quest = build(:quest, title: 'a' * 256)
        expect(quest).to be_invalid
        expect(quest.errors[:title]).to include('は255文字以内で入力してください')
      end
    end
  
    context 'bodyが65535文字以内の場合' do
      it '有効であること' do
        quest = build(:quest, body: 'a' * 65535)
        expect(quest).to be_valid
      end
    end
  
    context 'bodyが65536文字以上の場合' do
      it '無効であること' do
        quest = build(:quest, body: 'a' * 65536)
        expect(quest).to be_invalid
        expect(quest.errors[:body]).to include('は65535文字以内で入力してください')
      end
    end
  end
end