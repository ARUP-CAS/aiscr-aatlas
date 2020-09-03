class CorrectCollationEn < ActiveRecord::Migration
  def up
    execute 'ALTER TABLE places ALTER COLUMN title_en TYPE varchar COLLATE "en_US";'
  end
end
