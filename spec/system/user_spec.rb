require 'rails_helper'

RSpec.describe 'ユーザーテスト' , type: :system do
    describe 'ユーザー登録のテスト' do
        it 'ユーザーの新規登録ができること' do
            visit new_user_path
            fill_in 'user[name]', with: 'sample'
            fill_in 'user[email]', with: 'sample@example.com'
            fill_in 'user[password]', with: '00000000'
            fill_in 'user[password_confirmation]', with: '00000000'
            click_on 'Create my account'
            expect(current_path).to eq user_path(id: User.last.id)
        end
        it 'ユーザがログインしていないのにタスク一覧のページに飛ぼうとした場合ログイン画面に遷移すること' do
            visit tasks_path
            expect(current_path).to eq new_session_path
        end
    end
    describe 'セッション機能のテスト' do
        it 'ログインができること' do
            user = FactoryBot.create(:user, email: 'sample@example.com', password: '00000000')
            visit new_session_path
            fill_in 'Email', with: 'sample@example.com'
            fill_in 'Password', with: '00000000'
            click_on 'Log in'
            expect(current_path).to eq user_path(id: User.last.id)
        end
        it '自分の詳細画面(マイページ)に飛べること' do
            user = FactoryBot.create(:user, email: 'sample@example.com', password: '00000000')
            visit new_session_path
            fill_in 'Email', with: 'sample@example.com'
            fill_in 'Password', with: '00000000'
            click_on 'Log in'
            click_on 'Profile'
            expect(current_path).to eq user_path(id: User.last.id)
        end
        it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do
            user1 = FactoryBot.create(:user)
            user2 = FactoryBot.create(:user, email: 'sample@example.com', password: '00000000')
            visit new_session_path
            fill_in 'Email', with: 'sample@example.com'
            fill_in 'Password', with: '00000000'
            click_on 'Log in'
            visit user_path(id: user1.id)
            expect(current_path).to eq tasks_path
        end
        it 'ログアウトができること' do
            user = FactoryBot.create(:user, email: 'sample@example.com', password: '00000000')
            visit new_session_path
            fill_in 'Email', with: 'sample@example.com'
            fill_in 'Password', with: '00000000'
            click_on 'Log in'
            click_on 'Logout'
            expect(current_path).to eq new_session_path
        end
    end
    describe '管理画面のテスト' do
        it '管理者は管理画面にアクセスできること' do
            user = FactoryBot.create(:user, email: 'admin@example.com', password: '00000000', admin: true)
            visit new_session_path
            fill_in 'Email', with: 'admin@example.com'
            fill_in 'Password', with: '00000000'
            click_on 'Log in'
            visit admin_users_path
            expect(current_path).to eq admin_users_path
        end
        it '一般ユーザは管理画面にアクセスできないこと' do
            user = FactoryBot.create(:user, email: 'sample@example.com', password: '00000000')
            visit new_session_path
            fill_in 'Email', with: 'sample@example.com'
            fill_in 'Password', with: '00000000'
            click_on 'Log in'
            visit admin_users_path
            expect(current_path).to_not eq admin_users_path
        end
        it '管理者はユーザを新規登録できること' do
            user = FactoryBot.create(:user, email: 'admin@example.com', password: '00000000', admin: true)
            visit new_session_path
            fill_in 'Email', with: 'admin@example.com'
            fill_in 'Password', with: '00000000'
            click_on 'Log in'
            visit new_admin_user_path
            fill_in 'user[name]', with: 'sample'
            fill_in 'user[email]', with: 'sample@example.com'
            fill_in 'user[password]', with: '00000000'
            fill_in 'user[password_confirmation]', with: '00000000'
            click_on '登録'
            expect(current_path).to eq admin_users_path
        end
        it '管理者はユーザの詳細画面にアクセスできること' do
            user = FactoryBot.create(:user, email: 'admin@example.com', password: '00000000', admin: true)
            visit new_session_path
            fill_in 'Email', with: 'admin@example.com'
            fill_in 'Password', with: '00000000'
            click_on 'Log in'
            visit admin_users_path
            click_on 'ユーザー確認'
            expect(page).to have_content 'タスク詳細'
        end
        it '管理者はユーザの編集画面からユーザを編集できること' do
            user = FactoryBot.create(:user, email: 'admin@example.com', password: '00000000', admin: true)
            visit new_session_path
            fill_in 'Email', with: 'admin@example.com'
            fill_in 'Password', with: '00000000'
            click_on 'Log in'
            visit admin_users_path
            click_on 'ユーザー編集'
            fill_in 'user[name]', with: 'test_name'
            fill_in 'user[email]', with: 'sample@example.com'
            fill_in 'user[password]', with: '00000000'
            fill_in 'user[password_confirmation]', with: '00000000'
            click_on '更新する'
            visit admin_users_path
            expect(page).to have_content 'test_name'
        end
        it '管理者はユーザの削除をできること' do
            user1 = FactoryBot.create(:user, email: 'admin@example.com', password: '00000000', admin: true)
            user2 = FactoryBot.create(:user, name: 'normal')
            visit new_session_path
            fill_in 'Email', with: 'admin@example.com'
            fill_in 'Password', with: '00000000'
            click_on 'Log in'
            visit admin_users_path
            page.click_on 'ユーザー削除', match: :first
            page.driver.browser.switch_to.alert.accept
            expect(page).to_not have_content 'normal'
        end
    end
end
