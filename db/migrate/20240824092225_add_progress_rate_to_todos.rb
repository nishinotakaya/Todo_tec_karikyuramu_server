class AddProgressRateToTodos < ActiveRecord::Migration[7.1]
  def change
    add_column :todos, :progress_rate, :integer
  end
end
