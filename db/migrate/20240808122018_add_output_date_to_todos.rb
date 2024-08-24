class AddOutputDateToTodos < ActiveRecord::Migration[7.1]
  def change
    add_column :todos, :output_date, :date
  end
end
