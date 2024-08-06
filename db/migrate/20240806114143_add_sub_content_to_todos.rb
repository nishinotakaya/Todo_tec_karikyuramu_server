class AddSubContentToTodos < ActiveRecord::Migration[7.1]
  def change
    add_column :todos, :sub_content, :string
  end
end
