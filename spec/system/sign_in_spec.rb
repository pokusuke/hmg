require 'rails_helper'

describe "ログインのシステムテスト", type: :system do
  before do
    visit new_user_session_path
  end

  describe '有効なログインの場合' do
    before do
      user = FactoryBot.create(:user)
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'ログイン'
    end
    it 'ルートにリダイレクトされること' do  
      expect(current_path).to eq(root_path)
    end
    it 'ログイン後のメニュー一覧が表示されること' do
      within '.header-nav' do
        expect(page).to have_content 'イベント検索'
        expect(page).to have_content '参加イベント'
        expect(page).to have_content 'プロフィール編集'
        expect(page).to have_content 'メッセージ'
        expect(page).to have_content 'ログアウト'
      end
    end
  end
  describe '無効なログインの場合' do
    before do
      fill_in 'user_email', with: 'a'
      fill_in 'user_password', with: 'a'
      click_button 'ログイン'
    end
    it 'ルートにリダイレクトされないこと' do
      expect(current_path).to_not eq(root_path)
    end
    it 'エラーメッセージが表示されること' do
      expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
    end
  end
  describe '本人認証が完了していないユーザのログインの場合' do
    before do
      user = FactoryBot.create(:user,confirmed_at:nil)
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'ログイン'
    end 
    it 'ルートにリダイレクトされないこと' do
      expect(current_path).to_not eq(root_path)
    end
    it '本人認証を促すメッセージが表示されること' do
      expect(page).to have_content 'メールアドレスの本人確認が必要です。'
    end      
  end
end