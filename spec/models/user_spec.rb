require 'rails_helper'

describe User do
  it '有効なUserレコードが登録できること' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it 'nameがなければ無効なこと' do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
  end

  it 'emailがなければ無効なこと' do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end

  it 'emailの形式が不正な場合無効なこと' do
    user = FactoryBot.build(:user, email: 'aaa')
    user.valid?
    expect(user.errors[:email]).to include('は不正な値です')
  end

  it 'emailの形式が正しい場合は有効なこと' do
    user = FactoryBot.build(:user, email: 'hoge@example.com')
    user.valid?
    expect(user).to be_valid
  end

  it 'パスワードなければ無効なこと' do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include('を入力してください')
  end

  it 'パスワードが6文字未満であれば無効なこと' do
    user = FactoryBot.build(:user, password: 'aa')
    expect(user).to_not be_valid
  end

  it 'パスワードが6文字以上であれば有効なこと' do
    user = FactoryBot.build(:user, password: 'abcdef')
    expect(user).to be_valid
  end

  it '重複したメールアドレスは無効なこと' do
    FactoryBot.create(:user, email: 'test@example.com')
    user = FactoryBot.build(:user, email: 'test@example.com')
    user.valid?
    expect(user.errors[:email]).to include('はすでに存在します')
  end
end
