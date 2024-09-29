class AddDatesToTodos < ActiveRecord::Migration[7.1]
  def change
    add_column :todos, :completion_date_actual, :date
  end
end
