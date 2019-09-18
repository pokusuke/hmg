require 'rails_helper'

describe Event do
  it '有効なEventレコードが登録できること' do
    expect(FactoryBot.build(:event)).to be_valid
  end

  it 'event_nameがなければ無効なこと' do
    event = FactoryBot.build(:event, event_name: nil)
    event.valid?
    expect(event.errors[:event_name]).to include 'を入力してください'
  end

  it 'event_nameが256以上であれば無効なこと' do
    event = FactoryBot.build(:event, event_name: 'a' * 256)
    event.valid?
    expect(event.errors[:event_name]).to include 'は255文字以内で入力してください'
  end

  it 'event_dateがなければ無効なこと' do
    event = FactoryBot.build(:event, event_date: nil)
    event.valid?
    expect(event.errors[:event_date]).to include 'を入力してください'
  end

  it 'event_published_flgがなければ無効なこと' do
    event = FactoryBot.build(:event, event_published_flg: nil)
    event.valid?
    expect(event.errors[:event_published_flg]).to include 'は一覧にありません'
  end

  it 'event_detailが2001文字以上であれば無効なこと' do
    event = FactoryBot.build(:event, event_detail: 'a' * 2001)
    event.valid?
    expect(event.errors[:event_detail]).to include 'は2000文字以内で入力してください'
  end

  it 'cityが256文字以上であれば無効なこと' do
    event = FactoryBot.build(:event, city: 'a' * 256)
    event.valid?
    expect(event.errors[:city]).to include 'は255文字以内で入力してください'
  end

  it 'place_detailが256文字以上であれば無効なこと' do
    event = FactoryBot.build(:event, place_detail: 'a' * 256)
    event.valid?
    expect(event.errors[:place_detail]).to include 'は255文字以内で入力してください'
  end

  it 'event_recruiting_flgがなければ無効なこと' do
    event = FactoryBot.build(:event, event_recruiting_flg: nil)
    event.valid?
    expect(event.errors[:event_recruiting_flg]).to include 'は一覧にありません'
  end

  it 'event_recruit_start_dateがevent_recruit_end_dateより大きければ無効であること' do
    event = FactoryBot.build(
      :event,
      event_recruit_start_date: 1.day.from_now,
      event_recruit_end_date: Date.current.in_time_zone
    )
    event.valid?
    expect(event.errors[:event_recruit_start_date]).to include 'は募集終了日より前の日付で指定してください'
  end

  it 'event_recruit_start_dateがevent_recruit_end_dateと同日以前で有効あること' do
    event = FactoryBot.build(
      :event,
      event_recruit_start_date: -1.day.from_now,
      event_recruit_end_date: Date.current.in_time_zone
    )
    expect(event).to be_valid
  end

  it 'event_recruit_numberは0未満は無効なこと' do
    event = FactoryBot.build(:event, event_recruit_number: -1)
    event.valid?
    expect(event.errors[:event_recruit_number]).to include 'は0以上の値にしてください'
  end

  it 'event_recruit_numberは少数は無効なこと' do
    event = FactoryBot.build(:event, event_recruit_number: 1.2)
    event.valid?
    expect(event.errors[:event_recruit_number]).to include 'は整数で入力してください'
  end

  it 'event_entrance_feeは0未満は無効なこと' do
    event = FactoryBot.build(:event, event_entrance_fee: -1)
    event.valid?
    expect(event.errors[:event_entrance_fee]).to include 'は0以上の値にしてください'
  end

  it 'event_entrance_feeは少数は無効なこと' do
    event = FactoryBot.build(:event, event_entrance_fee: 1.2)
    event.valid?
    expect(event.errors[:event_entrance_fee]).to include 'は整数で入力してください'
  end
end
