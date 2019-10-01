require 'rails_helper'

describe 'Userのシステムテスト', type: :system do
  let(:user1) { FactoryBot.create(:user, name: 'ユーザ1') }
  let(:user2) { FactoryBot.create(:user, :admin_user, name: '管理者ユーザ') }

  describe 'ユーザ一覧の表示' do
    before do
      visit new_user_session_path
      fill_in 'user_email', with: login_user.email
      fill_in 'user_password', with: login_user.password
      click_button 'ログイン'
      visit users_path
    end
    context '一般ユーザの場合' do
      let(:login_user) { user1 }
      it 'ホーム画面にリダイレクトされること' do
        expect(current_path).to eq(root_path)
      end
    end
    context '管理者ユーザの場合' do
      let(:login_user) { user2 }
      it '一覧画面が表示できること' do
        expect(current_path).to eq(users_path)
      end
    end
  end
end
