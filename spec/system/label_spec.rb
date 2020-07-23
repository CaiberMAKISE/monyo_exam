require 'rails_helper'
RSpec.describe 'ラベル作成機能', type: :system do
  describe 'ラベル一覧画面' do
    context 'ラベルを作成した場合' do
      it '作成済みのラベルが表示される' do
        user = FactoryBot.create(:user, email: 'sample@example.com', password: '00000000')
        visit new_session_path
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: '00000000'
        click_on 'Log in'
        label = FactoryBot.create(:label)
        visit admin_labels_path
        expect(page).to have_content 'default'
      end
    end
    context 'ラベルを編集した場合' do
      it '変更が適用される' do
        user = FactoryBot.create(:user, email: 'sample@example.com', password: '00000000')
        visit new_session_path
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: '00000000'
        click_on 'Log in'
        label = FactoryBot.create(:label)
        visit admin_labels_path
        click_on 'ラベル編集'
        fill_in 'Content', with: 'default!'
        click_on '更新する'
        expect(page).to have_content 'default!'
      end
    end
  end
  describe 'タスクへのラベル登録機能' do
    context 'タスクを登録した時' do
      it '詳細画面で登録ラベルが見られる' do
        user = FactoryBot.create(:user, email: 'sample@example.com', password: '00000000')
        visit new_session_path
        fill_in 'Email', with: 'sample@example.com'
        fill_in 'Password', with: '00000000'
        click_on 'Log in'
        label = FactoryBot.create(:label)
        visit new_task_path
        fill_in 'task_title', with: 'test'
        fill_in 'task_content', with: 'test'
        check 'default'
        click_on '登録する'
        click_on 'タスクを確認する'
        expect(page).to have_content 'default'
      end
    end
  end
end