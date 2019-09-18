require 'rails_helper'

describe EventMsg do
  it '有効なEventMsgが登録されること' do
    expect(FactoryBot.create(:event_msg)).to be_valid
  end

  it 'メッセージは401文字以上で無効であること' do
    event_msg = FactoryBot.build(:event_msg, msg: 'a' * 401)
    event_msg.valid?
    expect(event_msg.errors[:msg]).to include 'は400文字以内で入力してください'
  end
end
