class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :content
      t.boolean :completed
      t.boolean :delete_flg

      t.timestamps
    end
  end
end
