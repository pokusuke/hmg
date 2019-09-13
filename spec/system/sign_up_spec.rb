require 'rails_helper'

describe "新規ユーザ登録のシステムテスト", type: :system do
  before do
    visit new_user_registration_path
  end

  describe '有効なユーザの場合' do
    before do
      fill_in 'user_name', with: 'テストユーザ1'
      fill_in 'user_email', with: 'test1@example.com'
      fill_in 'user_password', with: 'hogehoge'
      fill_in 'user_password_confirmation', with: 'hogehoge'
      click_button '登録'
    end
    it 'メールが送られること' do
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end
    it 'ルートにリダイレクトされること' do  
      expect(current_path).to eq(root_path)
    end
    it '本人確認のメッセージが表示されること' do
      expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
    end
  end

  describe '無効なユーザの場合' do
    before do
      click_button '登録'
    end
    it 'メールが送られないこと' do
      expect(ActionMailer::Base.deliveries.size).to_not eq(1)
    end
    it 'ルートにリダイレクトされないこと' do  
      expect(current_path).to_not eq(root_path)
    end
    it '名前のエラーメッセージが表示されること' do
      expect(page).to have_content '名前を入力してください'
    end
    it 'メールアドレスのエラーメッセージが表示されること' do
      expect(page).to have_content 'メールアドレスを入力してください'
    end
    it 'パスワードのエラーメッセージが表示されること' do
      expect(page).to have_content 'パスワードを入力してください'
    end    
  end
end