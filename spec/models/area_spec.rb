require 'rails_helper'

describe Area do
  it '有効なAreaレコードが登録できること' do
    expect(FactoryBot.create(:area)).to be_valid
  end

  it 'area_nameがなければ無効なこと' do
    area = FactoryBot.build(:area, area_name: nil)
    area.valid?
    expect(area.errors[:area_name]).to include "を入力してください"
  end

  it 'area_nameは51文字以上は入力できないこと' do
    area = FactoryBot.build(:area, area_name: "a"*52 )
    area.valid?
    expect(area.errors[:area_name]).to include "は50文字以内で入力してください"
  end


  it 'area_nameは重複しないこと' do
    FactoryBot.create(:area, area_name: "aaa")
    area = FactoryBot.build(:area, area_name: "aaa")
    area.valid?
    expect(area.errors[:area_name]).to include "はすでに存在します"
  end
end
