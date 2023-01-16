require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create :user }
  let(:man) { create :user, :man }
  let(:woman) { create :user, :woman }
  let(:another_woman) { create :user, :another_woman }
  describe 'ユーザーが女性の場合について' do
    before do
      login(woman)
    end
    context '「only_woman」にチェックを入れてイベントを登録する' do
      it '女性限定のイベントが作成できること' do
        visit new_event_path

        # labelの存在確認
        expect(page).to have_selector('label', text: 'Title'), 'Title というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Content'), 'Content というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Only women'), 'Only women というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Held at'), 'Held at というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Prefecture'), 'Prefecture というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Thumbnail'), 'Thumbnail というラベルが表示されていることを確認してください'

        # labelとフィールドの対応付け確認
        expect(page).to have_css("label[for='event_title']"), 'Title というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='event_content']"), 'Content というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='event_only_women']"), 'Only women というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='event_held_at']"), 'Held at というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='event_thumbnail']"), 'Thumbnail というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

        # イベント作成用ボタンの存在確認
        expect(page).to have_button('登録'), 'イベント作成用のボタンが表示されていることを確認してください'

        # イベント新規作成用の処理
        expect {
            fill_in 'Title', with: 'test01'
            fill_in 'Content', with: 'test01@example.com'
            check 'event_only_women'
            fill_in "Held at", with: "002023-11-11-00-00"
            select "東京都", from: "event_prefecture_id"
            click_on '登録'
        }.to change { Event.count }.by(1) # 処理結果の確認

        expect(page).to have_content('女性限定'), '女性限定 というラベルが表示されていることを確認してください'

        visit root_path
        expect(page).to have_content('女性限定'), '女性限定 というラベルが表示されていることを確認してください'
      end
    end

    context '「only_woman」にチェックを入れずにイベントを登録する' do
      it '通常のイベントが作成できること' do
        visit new_event_path

        # labelの存在確認
        expect(page).to have_selector('label', text: 'Title'), 'Title というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Content'), 'Content というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Only women'), 'Only women というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Held at'), 'Held at というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Prefecture'), 'Prefecture というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Thumbnail'), 'Thumbnail というラベルが表示されていることを確認してください'

        # labelとフィールドの対応付け確認
        expect(page).to have_css("label[for='event_title']"), 'Title というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='event_content']"), 'Content というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='event_only_women']"), 'Only women というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='event_held_at']"), 'Held at というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='event_thumbnail']"), 'Thumbnail というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

        # イベント作成用ボタンの存在確認
        expect(page).to have_button('登録'), 'イベント作成用のボタンが表示されていることを確認してください'

        # イベント新規作成用の処理
        expect {
            fill_in 'Title', with: 'test01'
            fill_in 'Content', with: 'test01@example.com'
            uncheck 'event_only_women'
            fill_in "Held at", with: "002023-11-11-00-00"
            select "東京都", from: "event_prefecture_id"
            click_on '登録'
        }.to change { Event.count }.by(1) # 処理結果の確認

        expect(page).not_to have_content('女性限定'), '女性限定 というラベルが表示されていないことを確認してください'

        visit root_path
        expect(page).not_to have_content('女性限定'), '女性限定 というラベルが表示されていないことを確認してください'
      end
    end

    context '女性限定のイベントに参加する' do
      it '女性限定のイベントに参加ができること' do
        create(:event, only_women: :only_woman)
        visit '/events/1'

        # イベント詳細画面の状況確認
        expect(page).to have_content('女性限定'), 'イベントが女性限定であることを確認してください'
        expect(page).to have_content('このもくもく会に参加する'), 'イベント参加用のボタンが表示されていることを確認してください'

        page.accept_confirm do
          click_on 'このもくもく会に参加する'
        end

        expect(page).to have_content('キャンセルする'), 'キャンセル用のボタンが表示されていることを確認してください'
      end
    end
  end

  describe 'ユーザーが女性以外の場合について' do
    before do
      login(man)
    end
    context 'イベントを登録する' do
      it '女性限定のイベントが作成できないこと' do
        visit new_event_path

        # labelの存在確認
        expect(page).to have_selector('label', text: 'Title'), 'Title というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Content'), 'Content というラベルが表示されていることを確認してください'
        expect(page).not_to have_selector('label', text: 'Only women'), 'Only women というラベルが表示されていないことを確認してください'
        expect(page).to have_selector('label', text: 'Held at'), 'Held at というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Prefecture'), 'Prefecture というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Thumbnail'), 'Thumbnail というラベルが表示されていることを確認してください'

        # labelとフィールドの対応付け確認
        expect(page).to have_css("label[for='event_title']"), 'Title というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='event_content']"), 'Content というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='event_held_at']"), 'Held at というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='event_thumbnail']"), 'Thumbnail というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

        # イベント作成用ボタンの存在確認
        expect(page).to have_button('登録'), 'イベント作成用のボタンが表示されていることを確認してください'

        # イベント新規作成用の処理
        expect {
            fill_in 'Title', with: 'test01'
            fill_in 'Content', with: 'test01@example.com'
            fill_in "Held at", with: "002023-11-11-00-00"
            select "東京都", from: "event_prefecture_id"
            click_on '登録'
        }.to change { Event.count }.by(1) # 処理結果の確認

        expect(page).not_to have_content('女性限定'), '女性限定 というラベルが表示されていないことを確認してください'

        visit root_path
        expect(page).not_to have_content('女性限定'), '女性限定 というラベルが表示されていないことを確認してください'
      end
    end

    context 'イベントに参加する' do
      it '通常のイベントに参加ができること' do
        create(:event)
        visit '/events/1'

        # イベント詳細画面の状況確認
        expect(page).not_to have_content('女性限定'), 'イベントが女性限定ではないことを確認してください'
        expect(page).to have_content('このもくもく会に参加する'), 'イベント参加用のボタンが表示されていることを確認してください'

        page.accept_confirm do
          click_on 'このもくもく会に参加する'
        end

        expect(page).to have_content('キャンセルする'), 'キャンセル用のボタンが表示されていることを確認してください'
      end
    end
  end
end
