require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        task = FactoryBot.create(:task, title: 'task2')
        task = FactoryBot.create(:task, title: 'task3')
        visit tasks_path
        first_task = all('tbody tr')[1]
        second_task = all('tbody tr')[2]
        expect(first_task).to have_content 'task3'
        expect(second_task).to have_content 'task2'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'task_title', with: 'task'
        click_button '登録する'
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end
  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        visit tasks_path
        click_on 'タスクを確認する',match: :first
        expect(current_url).to have_content 'tasks'
      end
    end
  end
end