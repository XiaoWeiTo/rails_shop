class AddUserDefaultAddressId < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :default_address_id, :integer
  end
end
