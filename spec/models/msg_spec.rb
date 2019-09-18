require 'rails_helper'

describe Msg do
  it '有効なMsgレコードが登録できること' do
    expect(FactoryBot.create(:msg)).to be_valid
  end

  it 'メッセージが401文字以上で無効なこと' do
    msg = FactoryBot.build(:msg, msg: 'a' * 401)
    msg.valid?
    expect(msg.errors[:msg]).to include 'は400文字以内で入力してください'
  end
end
