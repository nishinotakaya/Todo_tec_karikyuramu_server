class AddSortToTodos < ActiveRecord::Migration[7.1]
  def change
    add_column :todos, :sort, :integer

    reversible do |dir|
      dir.up do
        Todo.reset_column_information
        Todo.order(:created_at).each_with_index do |todo, index|
          todo.update_column(:sort, index + 1)
        end
      end
    end
  end
end
