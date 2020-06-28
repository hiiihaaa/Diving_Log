require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    it "nickname・email・passwordで登録できる" do 
      expect(create(:user)).to be_valid
    end 
  
    it "nicknameが空なら登録できない" do 
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end 
    it "emailが空なら登録できない" do 
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end 
    it "passwordが空なら登録できない" do 
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end 
    
    it "emailが重複していたら登録できない" do 
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end 
    it "password_confirmationとpasswordが異なる場合保存できない" do 
      user = build(:user, password: "00000000" ,password_confirmation: "11111111")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    it "passwordが6文字以下では保存できない" do 
      user = build(:user, password: "00000" ,password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
    it "パスワードが暗号化されている" do 
      user = create(:user)
      expect(user.encrypted_password).to_not eq "password"
    end 
  end
end