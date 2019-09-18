require 'rails_helper'

describe EventApp do
  it '有効なEventAppレコードが登録できること' do
    expect(FactoryBot.create(:event_app)).to be_valid
  end

  it '同一のuserが同一のEventのEventAppに追加されないこと' do
    user = FactoryBot.create(:user)
    event = FactoryBot.create(:event)
    FactoryBot.create(
      :event_app,
      user: user,
      event: event
    )
    other_event_app = FactoryBot.build(
      :event_app,
      user: user,
      event: event
    )
    other_event_app.valid?
    expect(other_event_app.errors[:user_id]).to include 'はすでに存在します'
  end
end
