class Label < ApplicationRecord
    has_many :labellings
    has_many :tasks, through: :labelling
    validates :content, presence: true
end
