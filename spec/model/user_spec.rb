require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    it "nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is valid with a email" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "emailがない場合は登録できないこと" do
      # user = User.new(nickname: "nick", email: "",password: "00000000", password_confirmation: "00000000")
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
  end
end