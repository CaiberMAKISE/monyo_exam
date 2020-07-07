require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end
  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
    task = FactoryBot.create(:task, title: '成功テスト', content: '成功テスト')
    expect(task).to be_valid
  end
  context 'scopeメソッドで検索をした場合' do
    before do
        task = FactoryBot.create(:task, title: 'task7/2', dead_line: '2020-07-02')
        task = FactoryBot.create(:task, title: 'task7/3', dead_line: '2020-07-03')
        task = FactoryBot.create(:task, title: 'task7/1', dead_line: '2020-07-01')
    end
    it "scopeメソッドでタイトル検索ができる" do
      expect(Task.title_search('task7/1').count).to eq 1
    end
    it "scopeメソッドでステータス検索ができる" do
        expect(Task.status_search('未着手').count).to eq 3
    end
    it "scopeメソッドでタイトルとステータスの両方が検索できる" do
        expect(Task.title_search('task7/1').status_search('未着手').count).to eq 1
    end
  end
end