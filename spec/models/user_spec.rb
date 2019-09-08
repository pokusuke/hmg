require 'rails_helper'

describe 'validation' do
  it '有効なUserレコードが新規登録できること' do
    user = User.create(
      name: 'ユーザA',
      email: 'userA@example.com',
      password: 'password'
    )
    expect(user).to be_valid
  end
end