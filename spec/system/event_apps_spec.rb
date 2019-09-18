require 'rails_helper'

describe '参加イベントのシステムテスト', type: :system do
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

  describe '参加イベント一覧画面' do
    before do
      visit new_user_session_path
      fill_in 'user_email', with: login_user.email
      fill_in 'user_password', with: login_user.password
      click_button 'ログイン'
      visit event_apps_path
    end

    context '自分が作成したイベントの場合' do
      let(:login_user) { user1 }
      it '作成したイベントが表示されていること' do
        expect(page).to have_content(event.event_name)
      end
    end

    context '他者が作成したイベントに参加した場合' do
      let(:login_user) { user2 }
      it '参加したイベントが表示されていること' do
        expect(page).to have_content(event.event_name)
      end
    end

    context '他者が作成したイベントに参加していない場合' do
      let(:login_user) { user3 }
      it '参加していないイベントは表示されていないこと' do
        expect(page).to_not have_content(event.event_name)
      end
    end
  end

  describe '参加イベント詳細画面' do
    before do
      visit new_user_session_path
      fill_in 'user_email', with: login_user.email
      fill_in 'user_password', with: login_user.password
      click_button 'ログイン'
      visit event_app_path(event_app1)
    end
    context '自分が作成したイベントの場合' do
      let(:login_user) { user1 }
      it 'イベント編集のリンクが表示されていること' do
        expect(page).to have_content('イベント編集')
      end
    end

    context '他者が作成したイベントに参加している場合' do
      let(:login_user) { user2 }
      it 'イベント編集のリンクが表示されていないこと' do
        expect(page).to_not have_content('イベント編集')
      end
    end

    context '他者が作成したイベントに参加していない場合' do
      let(:login_user) { user3 }
      it '参加イベント一覧画面へリダイレクトされること' do
        expect(current_path).to eq(event_apps_path)
      end
    end
  end
end
