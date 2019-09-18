require 'rails_helper'

describe Pref do
  it '有効なPrefレコードが登録できること' do
    expect(FactoryBot.create(:pref)).to be_valid
  end

  it 'pref_idがなければ無効なこと' do
    pref = FactoryBot.build(:pref, pref_id: nil)
    pref.valid?
    expect(pref.errors[:pref_id]).to include 'を入力してください'
  end

  it 'pref_idは4文字以上では無効なこと' do
    pref = FactoryBot.build(:pref, pref_id: 'a' * 4)
    pref.valid?
    expect(pref.errors[:pref_id]).to include 'は3文字以内で入力してください'
  end

  it 'pref_idは重複しないこと' do
    FactoryBot.create(:pref, pref_id: '12')
    pref = FactoryBot.build(:pref, pref_id: '12')
    pref.valid?
    expect(pref.errors[:pref_id]).to include 'はすでに存在します'
  end

  it 'pref_nameがなければ無効なこと' do
    pref = FactoryBot.build(:pref, pref_name: nil)
    pref.valid?
    expect(pref.errors[:pref_name]).to include 'を入力してください'
  end

  it 'pref_nameは51文字以上で無効なこと' do
    pref = FactoryBot.build(:pref, pref_name: 'a' * 51)
    pref.valid?
    expect(pref.errors[:pref_name]).to include 'は50文字以内で入力してください'
  end
end
