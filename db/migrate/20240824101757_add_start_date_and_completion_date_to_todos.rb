class AddStartDateAndCompletionDateToTodos < ActiveRecord::Migration[7.1]
  def change
    add_column :todos, :start_date, :date
    add_column :todos, :completion_date, :date
  end
end
