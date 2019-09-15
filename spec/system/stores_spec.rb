require 'rails_helper'

describe "出店情報画面のシステムテスト", type: :system do
  let(:user1) { FactoryBot.create(:user, name: 'ユーザ1') }
  let(:user2) { FactoryBot.create(:user, name: 'ユーザ2') }
  let!(:pref) { FactoryBot.create(:pref, pref_id: '1',pref_name:'A県')}
  
  let(:event){ FactoryBot.create(:event, event_name:'参加イベントのテスト' ,user: user1, pref: pref)}
  let!(:event_app1){ FactoryBot.create(:event_app, event: event, user: user1 )}

  describe '出店情報の新規作成' do
    before do
      visit new_user_session_path
      fill_in 'user_email', with: login_user.email
      fill_in 'user_password', with: login_user.password
      click_button 'ログイン'
      visit new_event_app_store_path(event_app1.id)
    end
    context '自身の参加イベントの出店情報の場合' do
      let(:login_user){ user1 }
      context '有効な入力をしたイベントの場合' do
        it '登録成功のメッセージが表示されること' do
          fill_in '出店名', with: 'テスト店舗'
          fill_in '出店情報', with: 'テストの店舗です'
          click_button '登録'
          expect(page).to have_content('保存しました')
        end
      end
      context '無効な入力をしたイベントの場合' do
        it '不正な入力のメッセージが表示されること' do
          click_button '登録'
          expect(page).to have_content('不正な入力があります')
        end
      end
    end
    context '自身が参加していないイベント情報の場合' do
      let(:login_user){ user2 }
      it '参加イベント一覧画面にリダイレクトされること' do
        expect(current_path).to eq(event_apps_path)
      end
    end
  end

  describe '出店情報の編集と削除' do
    let(:store){ FactoryBot.create(:store,user: user1,event_app: event_app1)}
    let(:login_user) { user1 }
    before do
      visit new_user_session_path
      fill_in 'user_email', with: login_user.email
      fill_in 'user_password', with: login_user.password
      click_button 'ログイン'
      visit edit_event_app_store_path(event_app1.id,store.id)
    end
    context '有効な入力をした場合' do
      it '登録成功のメッセージが表示されること' do
        click_button '登録'
        expect(page).to have_content('保存しました')
      end
    end
    context '無効な入力した場合' do
      it '不正な入力のメッセージが表示されること' do
        fill_in '出店名', with: nil
        click_button '登録'
        expect(page).to have_content('不正な入力があります')
      end
    end
    context '削除した場合' do
      it '参加イベント詳細画面にリダイレクトされること' do
        click_link '削除する'
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq(event_app_path(event_app1.id))
      end
    end
  end
end