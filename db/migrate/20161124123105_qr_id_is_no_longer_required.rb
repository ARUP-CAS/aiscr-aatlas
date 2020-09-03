class QrIdIsNoLongerRequired < ActiveRecord::Migration
  def change
    change_column :places, :qr_id, :string, null: true
  end
end
