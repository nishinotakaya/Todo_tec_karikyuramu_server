class AddCopyIdToTodos < ActiveRecord::Migration[7.1]
  def change
    add_column :todos, :copy_id, :bigint
    add_index :todos, :copy_id
  end
end
