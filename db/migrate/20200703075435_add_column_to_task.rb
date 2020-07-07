class AddColumnToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :dead_line, :date, null: false, default: ''
    add_column :tasks, :status, :string, null: false, default: '' 
  end
end
