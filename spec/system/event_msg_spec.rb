require 'rails_helper'

describe 'イベントメッセージのシステムテスト', type: :system do
  let(:user1) { FactoryBot.create(:user, name: 'ユーザ1') }
  let(:user2) { FactoryBot.create(:user, name: 'ユーザ2') }
  let(:user3) { FactoryBot.create(:user, name: 'ユーザ3') }
  let!(:pref) { FactoryBot.create(:pref, pref_id: '1', pref_name: 'A県') }

  let(:event) { FactoryBot.create(:event, event_name: '参加イベントのテスト', user: user1, pref: pref) }
  let!(:event_app1) { FactoryBot.create(:event_app, event: event, user: user1) }
  let!(:event_app2) { FactoryBot.create(:event_app, event: event, user: user2) }

  #  before do
  #    visit new_user_session_path
  #    fill_in 'user_email', with: login_user.email
  #    fill_in 'user_password', with: login_user.password
  #    click_button 'ログイン'
  #  end

  describe 'イベントチャット作成画面' do
    before do
      visit new_user_session_path
      fill_in 'user_email', with: login_user.email
      fill_in 'user_password', with: login_user.password
      click_button 'ログイン'
      visit event_msgs_path(event_id: event.id)
    end

    context '参加しているイベントの場合' do
      let(:login_user) { user1 }
      it '送信したメッセージが表示されていること' do
        fill_in 'メッセージ', with: 'テストメッセージ'
        click_button 'メッセージを送信'
        expect(page).to have_content('テストメッセージ')
      end
    end
    context '参加していないイベントの場合' do
      let(:login_user) { user3 }
      it '参加イベント一覧画面にリダイレクトされること' do
        expect(current_path).to eq(event_apps_path)
      end
    end
  end
end
