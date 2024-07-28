class ChangeDatabaseToUtf8mb4 < ActiveRecord::Migration[7.1]
  def change
    execute "ALTER DATABASE #{ActiveRecord::Base.connection.current_database} CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;"
    
    ActiveRecord::Base.connection.tables.each do |table|
      execute "ALTER TABLE #{table} CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    end
  end
end
