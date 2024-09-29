class Todo < ApplicationRecord
  validates :copy_id, uniqueness: { scope: :output_date, message: "同じcopy_idとoutput_dateのレコードは既に存在します" }
end
