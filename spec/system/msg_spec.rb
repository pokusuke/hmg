require 'rails_helper'

describe 'メッセージのシステムテスト', type: :system do
  let(:user1) { FactoryBot.create(:user, name: 'ユーザ1', nick_name: 'ユーザ1') }
  let!(:user2) { FactoryBot.create(:user, name: 'ユーザ2', nick_name: 'ユーザ2') }
  let!(:user3) { FactoryBot.create(:user, name: 'ユーザ3', nick_name: 'ユーザ3') }

  before do
    visit new_user_session_path
    fill_in 'user_email', with: login_user.email
    fill_in 'user_password', with: login_user.password
    click_button 'ログイン'
  end

  describe 'メッセージ送信先ユーザ検索画面' do
    let(:login_user) { user1 }
    before do
      visit msgs_select_user_path
      fill_in '検索するユーザ名', with: 'ユーザ'
      click_button '検索'
    end

    it '自分以外のユーザが検索結果に表示されること' do
      expect(find('.search-result')).to have_content('ユーザ2')
      expect(find('.search-result')).to have_content('ユーザ3')
    end
    it '自分自身は検索結果に表示されないこと' do
      expect(find('.search-result')).to_not have_content('ユーザ1')
    end
  end
end
