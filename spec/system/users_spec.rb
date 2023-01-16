require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'ユーザー新規作成' do
    context 'genderを指定なしで登録する' do
      it 'genderを指定なしにしたら指定なしで登録されること' do
        visit signup_path

        # labelの存在確認
        expect(page).to have_selector('label', text: 'Name'), 'Name というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Gender'), 'Gender というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Password confirmation'), 'Password confirmation というラベルが表示されていることを確認してください'

        # labelとフィールドの対応付け確認
        expect(page).to have_css("label[for='user_name']"), 'Name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_gender']"), 'Gender というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_password_confirmation']"), 'Password confirmation というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'

        # ユーザー作成用ボタンの存在確認
        expect(page).to have_button('登録'), 'ユーザー作成用のボタンが表示されていることを確認してください'

        # ユーザー新規作成用の処理
        expect {
            fill_in 'Name', with: 'test01'
            fill_in 'Email', with: 'test01@example.com'
            select "指定なし", from: "user_gender"
            fill_in 'Password', with: 'password'
            fill_in 'Password confirmation', with: 'password'
            check 'agreeCheck'
            click_on '登録'
        }.to change { User.count }.by(1) # 処理結果の確認

        visit mypage_profile_path
        expect(page).to have_content('指定なし'), '指定なし とが表示されていることを確認してください'
      end
    end

    context 'genderをLGBTにして登録する' do
      it 'genderをLGBTにしたらLGBTで登録されること' do
        visit signup_path
  
        # labelの存在確認
        expect(page).to have_selector('label', text: 'Name'), 'Name というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Gender'), 'Gender というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Password confirmation'), 'Password confirmation というラベルが表示されていることを確認してください'
  
        # labelとフィールドの対応付け確認
        expect(page).to have_css("label[for='user_name']"), 'Name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_gender']"), 'Gender というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_password_confirmation']"), 'Password confirmation というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
  
        # ユーザー作成用ボタンの存在確認
        expect(page).to have_button('登録'), 'ユーザー作成用のボタンが表示されていることを確認してください'
  
        # ユーザー新規作成用の処理
        expect {
            fill_in 'Name', with: 'test01'
            fill_in 'Email', with: 'test01@example.com'
            select "LGBT", from: "user_gender"
            fill_in 'Password', with: 'password'
            fill_in 'Password confirmation', with: 'password'
            check 'agreeCheck'
            click_on '登録'
        }.to change { User.count }.by(1) # 処理結果の確認
  
        visit mypage_profile_path
        expect(page).to have_content('LGBT'), 'LGBT と表示されていることを確認してください'
      end
    end

    context 'genderを男性にして登録する' do
      it 'genderを男性にしたら男性で登録されること' do
        visit signup_path
    
        # labelの存在確認
        expect(page).to have_selector('label', text: 'Name'), 'Name というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Gender'), 'Gender というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Password confirmation'), 'Password confirmation というラベルが表示されていることを確認してください'
    
        # labelとフィールドの対応付け確認
        expect(page).to have_css("label[for='user_name']"), 'Name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_gender']"), 'Gender というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_password_confirmation']"), 'Password confirmation というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
    
        # ユーザー作成用ボタンの存在確認
        expect(page).to have_button('登録'), 'ユーザー作成用のボタンが表示されていることを確認してください'
    
        # ユーザー新規作成用の処理
        expect {
            fill_in 'Name', with: 'test01'
            fill_in 'Email', with: 'test01@example.com'
            select "男性", from: "user_gender"
            fill_in 'Password', with: 'password'
            fill_in 'Password confirmation', with: 'password'
            check 'agreeCheck'
            click_on '登録'
        }.to change { User.count }.by(1) # 処理結果の確認
    
        visit mypage_profile_path
        expect(page).to have_content('男性'), '男性 と表示されていることを確認してください'
      end
    end

    context 'genderを女性にして登録する' do
      it 'genderを女性にしたら女性で登録されること' do
        visit signup_path
    
        # labelの存在確認
        expect(page).to have_selector('label', text: 'Name'), 'Name というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Email'), 'Email というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Gender'), 'Gender というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Password'), 'Password というラベルが表示されていることを確認してください'
        expect(page).to have_selector('label', text: 'Password confirmation'), 'Password confirmation というラベルが表示されていることを確認してください'
    
        # labelとフィールドの対応付け確認
        expect(page).to have_css("label[for='user_name']"), 'Name というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_email']"), 'Email というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_gender']"), 'Gender というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_password']"), 'Password というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
        expect(page).to have_css("label[for='user_password_confirmation']"), 'Password confirmation というラベルをクリックすると対応するフィールドにフォーカスすることを確認してください'
    
        # ユーザー作成用ボタンの存在確認
        expect(page).to have_button('登録'), 'ユーザー作成用のボタンが表示されていることを確認してください'
    
        # ユーザー新規作成用の処理
        expect {
            fill_in 'Name', with: 'test01'
            fill_in 'Email', with: 'test01@example.com'
            select "女性", from: "user_gender"
            fill_in 'Password', with: 'password'
            fill_in 'Password confirmation', with: 'password'
            check 'agreeCheck'
            click_on '登録'
        }.to change { User.count }.by(1) # 処理結果の確認
    
        visit mypage_profile_path
        expect(page).to have_content('女性'), '女性 と表示されていることを確認してください'
      end
    end
  end
end
