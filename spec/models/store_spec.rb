require 'rails_helper'

describe Store do
  it '有効なStoreレコードが登録できること' do
    expect(FactoryBot.create(:store)).to be_valid
  end

  it 'store_nameがないと無効なこと' do
    store = FactoryBot.build(:store, name: nil)
    store.valid?
    expect(store.errors[:name]).to include 'を入力してください'
  end

  it 'store_descが2001文字以上の場合無効なこと' do
    store = FactoryBot.build(:store, store_desc: 'a' * 2001)
    store.valid?
    expect(store.errors[:store_desc]).to include 'は2000文字以内で入力してください'
  end
end
