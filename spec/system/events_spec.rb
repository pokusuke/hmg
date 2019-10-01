require 'rails_helper'

describe 'イベントのシステムテスト', type: :system do
  let(:user1) { FactoryBot.create(:user, name: 'ユーザ1') }
  let(:user2) { FactoryBot.create(:user, name: 'ユーザ2') }
  let!(:pref) { FactoryBot.create(:pref, pref_id: '1', pref_name: 'A県') }

  before do
    visit new_user_session_path
    fill_in 'user_email', with: login_user.email
    fill_in 'user_password', with: login_user.password
    click_button 'ログイン'
  end

  describe 'イベント新規作成機能' do
    let(:login_user) { user1 }

    before do
      visit new_event_path
      fill_in 'イベント名', with: event_name
      select event_published_flg, from: 'event_event_published_flg'
      select selected_pref, from: 'event_pref_id'
      click_button '登録する'
    end

    context '正常な入力を行った場合_公開' do
      let(:event_name) { 'テストイベント' }
      let(:event_published_flg) { '公開' }
      let(:selected_pref) { 'A県' }
      it 'イベント一覧画面にリダイレクトされること' do
        expect(current_path).to eq(events_path)
      end
      it 'イベント一覧画面でイベントが追加されていること' do
        expect(page).to have_content('テストイベント')
      end
      it '登録成功のメッセージが表示されていること' do
        expect(find('.flash-msg')).to have_content('イベントを登録しました')
      end
      it '参加イベント画面で作成したイベントが表示されていること' do
        visit event_apps_path
        expect(page).to have_content('テストイベント')
      end
    end
    context '正常な入力を行った場合_下書き' do
      let(:event_name) { 'テストイベント' }
      let(:event_published_flg) { '下書き' }
      let(:selected_pref) { 'A県' }
      it 'イベント一覧画面にリダイレクトされること' do
        expect(current_path).to eq(events_path)
      end
      it 'イベント一覧画面でイベントが追加されていないこと' do
        expect(page).to_not have_content('テストイベント')
      end
      it '登録成功のメッセージが表示されていること' do
        expect(find('.flash-msg')).to have_content('イベントを登録しました')
      end
      it '参加イベント画面で作成したイベントが表示されていること' do
        visit event_apps_path
        expect(page).to have_content('テストイベント')
      end
    end
    context '必須項目を入力しなかった場合' do
      let(:event_name) { nil }
      let(:event_published_flg) { '公開' }
      let(:selected_pref) { '選択してください' }

      it '不正な入力のエラーメッセージが表示されいること' do
        expect(find('.flash-msg')).to have_content('不正な入力があります')
      end
      it 'イベント名のバリデーションメッセージが表示されること' do
        expect(page).to have_content('イベント名を入力してください')
      end
      it '都道府県のバリデーションメッセージが表示されること' do
        expect(page).to have_content('都道府県を入力してください')
      end
      it '参加イベント画面でイベントが作成されていないこと' do
        visit event_apps_path
        expect(page).to have_content('参加予定のイベントはありません')
      end
    end
  end

  describe 'イベント編集機能' do
    let(:login_user) { user1 }
    let(:edit_event) do
      FactoryBot.create(
        :event,
        user: user1,
        pref: pref,
        event_recruit_start_date: Date.current.in_time_zone,
        event_recruit_end_date: Date.current.in_time_zone
      )
    end
    let(:event_app) { FactoryBot.create(:event_app, user: user1, event: edit_event) }
    before do
      visit edit_event_path(event_app.event)
      fill_in 'イベント名', with: event_name
      select selected_pref, from: 'event_pref_id'
      click_button '登録する'
    end

    context '正常な入力を行った場合' do
      let(:event_name) { 'テストイベント2' }
      let(:selected_pref) { 'A県' }
      it 'イベント一覧画面にリダイレクトされないこと' do
        expect(current_path).to eq(event_path(edit_event))
      end
      it '登録成功のメッセージが表示されていること' do
        expect(find('.flash-msg')).to have_content('保存しました')
      end
    end

    context '必須項目を入力しなかった場合' do
      let(:event_name) { nil }
      let(:selected_pref) { 'A県' }

      it '不正な入力のエラーメッセージが表示されいること' do
        expect(find('.flash-msg')).to have_content('不正な入力があります')
      end
      it 'イベント名のバリデーションメッセージが表示されること' do
        expect(find('.form-error')).to have_content('イベント名を入力してください')
      end
    end
  end

  describe 'イベント削除機能' do
    let(:login_user) { user1 }
    let(:edit_event) do
      FactoryBot.create(
        :event,
        user: user1,
        pref: pref,
        event_recruit_start_date: Date.current.in_time_zone,
        event_recruit_end_date: Date.current.in_time_zone
      )
    end
    let(:event_app) { FactoryBot.create(:event_app, user: user1, event: edit_event) }
    before do
      visit edit_event_path(event_app.event)
      click_link '削除する'
      page.driver.browser.switch_to.alert.accept
    end

    it '参加イベント一覧画面にリダイレクトされること' do
      expect(current_path).to eq(event_apps_path)
    end

    it '削除メッセージが表示されること' do
      expect(find('.flash-msg')).to have_content('イベントを削除しました')
    end

    it '削除したイベントが表示されないこと' do
      expect(page).to_not have_content(edit_event.event_name)
    end
  end
end
