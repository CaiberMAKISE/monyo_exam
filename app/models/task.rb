class Task < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    validates :dead_line, presence: true
    validates :status, presence: true
    scope :title_search, -> (title_key) { where('title like ?', "%#{title_key}%") }
    scope :status_search, -> (status_key) { where('status like ?', "%#{status_key}%") }
    enum priority: { 低: 0, 中: 1, 高: 2 }
end
