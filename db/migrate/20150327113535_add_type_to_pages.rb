class AddTypeToPages < ActiveRecord::Migration
  def change
    add_column :places, :type, :string, default: 'Place'
  end
end
