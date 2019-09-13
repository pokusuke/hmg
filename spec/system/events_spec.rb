require 'rails_helper'

describe "イベントのシステムテスト", type: :system do
  let(:user1) { FactoryBot.create(:user, name: 'ユーザ1') }
  let(:user2) { FactoryBot.create(:user, name: 'ユーザ2') }
  let!(:pref) { FactoryBot.create(:pref, pref_id: '1',pref_name:'A県')}
  
  before do
    visit new_user_session_path
    fill_in 'user_email', with: login_user.email
    fill_in 'user_password', with: login_user.password
    click_button 'ログイン'
  end

  describe 'イベント新規作成機能' do
    let(:login_user){ user1 }

    before do
      visit new_event_path
      fill_in 'イベント名', with: event_name
      select selected_pref, from: 'event_pref_id'
      click_button '登録する'
    end
    
    context '正常な入力を行った場合' do
      let(:event_name){ 'テストイベント' }
      let(:selected_pref){ 'A県' }
      it 'イベント一覧画面にリダイレクトされること' do  
        expect(current_path).to eq(events_path)
      end
      it 'イベント一覧画面でイベントが追加されていること' do
        expect(page).to have_content('テストイベント')
      end
      it '登録成功のメッセージが表示されていること' do 
        expect(page).to have_content('イベントを登録しました')
      end
    end
    
    context '必須項目を入力しなかった場合' do
      let(:event_name) { nil }
      let(:selected_pref) { '選択してください' }

      it '不正な入力のエラーメッセージが表示されいること' do
        expect(page).to have_content('不正な入力があります')
      end
      it 'イベント名のバリデーションメッセージが表示されること' do
        expect(page).to have_content('イベント名を入力してください')
      end
      it '都道府県のバリデーションメッセージが表示されること' do
        expect(page).to have_content('都道府県を入力してください')
      end
    end
  end
end