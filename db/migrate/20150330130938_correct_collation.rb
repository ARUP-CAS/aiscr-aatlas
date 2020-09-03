class CorrectCollation < ActiveRecord::Migration
  def up
    # FIXME: fails on clean bin/setup
    execute 'ALTER TABLE places ALTER COLUMN title_cs  TYPE varchar COLLATE "czech";'
  end
end
